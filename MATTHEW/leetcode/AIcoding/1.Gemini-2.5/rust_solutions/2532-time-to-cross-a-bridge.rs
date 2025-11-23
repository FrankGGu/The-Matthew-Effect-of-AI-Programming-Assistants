use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn find_crossing_time(n: i32, k: i32, time: Vec<Vec<i32>>) -> i64 {
        let n = n as usize;
        let k = k as i32;
        let time_arr: Vec<[i32; 4]> = time.into_iter().map(|v| [v[0], v[1], v[2], v[3]]).collect();

        let mut current_time: i64 = 0;
        let mut lanes_free: i32 = k;
        let mut finished_people_count: usize = 0;
        let mut last_person_finish_time: i64 = 0;
        let mut next_person_arrival_idx: usize = 0;

        // People waiting at the left bank to cross L->R
        // Stores (leftToRight_i, person_idx) - min-heap by leftToRight_i, then by person_idx
        let mut left_bank_wait_pq: BinaryHeap<Reverse<(i32, usize)>> = BinaryHeap::new();

        // People waiting at the right bank to cross R->L
        // Stores (rightToLeft_i, person_idx) - min-heap by rightToLeft_i, then by person_idx
        let mut right_bank_wait_pq: BinaryHeap<Reverse<(i32, usize)>> = BinaryHeap::new();

        // People currently crossing L->R
        // Stores (finish_time, person_idx) - min-heap by finish_time
        let mut active_l_r_crossing: BinaryHeap<Reverse<(i64, usize)>> = BinaryHeap::new();

        // People currently picking up old items at the right bank
        // Stores (finish_time, person_idx) - min-heap by finish_time
        let mut active_picking_old: BinaryHeap<Reverse<(i64, usize)>> = BinaryHeap::new();

        // People currently crossing R->L
        // Stores (finish_time, person_idx) - min-heap by finish_time
        let mut active_r_l_crossing: BinaryHeap<Reverse<(i64, usize)>> = BinaryHeap::new();

        // People currently putting down new items at the left bank
        // Stores (finish_time, person_idx) - min-heap by finish_time
        let mut active_putting_new: BinaryHeap<Reverse<(i64, usize)>> = BinaryHeap::new();

        loop {
            // 1. If all people have finished, break.
            if finished_people_count == n {
                break;
            }

            // 2. Determine the next relevant time point.
            let mut next_possible_event_time = i64::MAX;

            // Check completion times of active tasks
            if let Some(Reverse((t, _))) = active_l_r_crossing.peek() { next_possible_event_time = next_possible_event_time.min(*t); }
            if let Some(Reverse((t, _))) = active_picking_old.peek() { next_possible_event_time = next_possible_event_time.min(*t); }
            if let Some(Reverse((t, _))) = active_r_l_crossing.peek() { next_possible_event_time = next_possible_event_time.min(*t); }
            if let Some(Reverse((t, _))) = active_putting_new.peek() { next_possible_event_time = next_possible_event_time.min(*t); }

            // Check arrival time of next person
            if next_person_arrival_idx < n {
                next_possible_event_time = next_possible_event_time.min(next_person_arrival_idx as i64);
            }

            // If there are no more events and no more people to arrive, but not all tasks finished,
            // it indicates an issue or an edge case where n=0.
            if next_possible_event_time == i64::MAX {
                break;
            }

            // Decide `target_time` for this iteration.
            // If there are people waiting at either bank AND lanes are free, we can try to assign them *at current_time*.
            // Otherwise (lanes are NOT free OR no one is waiting), `current_time` must jump to `next_possible_event_time`.
            let target_time: i64;
            if (left_bank_wait_pq.is_empty() && right_bank_wait_pq.is_empty()) || lanes_free == 0 {
                target_time = next_possible_event_time;
            } else {
                target_time = current_time;
            }

            // Advance current_time to `target_time`.
            current_time = current_time.max(target_time); // Ensure time only moves forward.

            // 3. Add newly arrived people to left_bank_wait_pq.
            while next_person_arrival_idx < n && (next_person_arrival_idx as i64) <= current_time {
                let person_id = next_person_arrival_idx;
                left_bank_wait_pq.push(Reverse((time_arr[person_id][0], person_id)));
                next_person_arrival_idx += 1;
            }

            // 4. Process all events that finish AT `current_time`.
            // This loop ensures all events at the current timestamp are processed.
            loop {
                let mut event_processed_at_current_time = false;

                // Process active_l_r_crossing
                if let Some(Reverse((finish_t, person_id))) = active_l_r_crossing.peek() {
                    if *finish_t <= current_time {
                        let Reverse((_, person_id)) = active_l_r_crossing.pop().unwrap();
                        lanes_free += 1;
                        active_picking_old.push(Reverse((current_time + time_arr[person_id][1] as i64, person_id)));
                        event_processed_at_current_time = true;
                    }
                }

                // Process active_picking_old
                if let Some(Reverse((finish_t, person_id))) = active_picking_old.peek() {
                    if *finish_t <= current_time {
                        let Reverse((_, person_id)) = active_picking_old.pop().unwrap();
                        right_bank_wait_pq.push(Reverse((time_arr[person_id][2], person_id)));
                        event_processed_at_current_time = true;
                    }
                }

                // Process active_r_l_crossing
                if let Some(Reverse((finish_t, person_id))) = active_r_l_crossing.peek() {
                    if *finish_t <= current_time {
                        let Reverse((_, person_id)) = active_r_l_crossing.pop().unwrap();
                        lanes_free += 1;
                        active_putting_new.push(Reverse((current_time + time_arr[person_id][3] as i64, person_id)));
                        event_processed_at_current_time = true;
                    }
                }

                // Process active_putting_new
                if let Some(Reverse((finish_t, person_id))) = active_putting_new.peek() {
                    if *finish_t <= current_time {
                        let Reverse((_, person_id)) = active_putting_new.pop().unwrap();
                        finished_people_count += 1;
                        last_person_finish_time = last_person_finish_time.max(*finish_t);
                        event_processed_at_current_time = true;
                    }
                }

                if !event_processed_at_current_time {
                    break; // No more events at current_time
                }
            }

            // 5. Assign people to lanes (prioritize R->L if available)
            while lanes_free > 0 {
                let mut assigned_this_turn = false;

                // Try to assign from right bank (priority)
                if let Some(Reverse((_, _))) = right_bank_wait_pq.peek() {
                    let Reverse((r_to_l_time, person_id)) = right_bank_wait_pq.pop().unwrap();
                    active_r_l_crossing.push(Reverse((current_time + r_to_l_time as i64, person_id)));
                    lanes_free -= 1;
                    assigned_this_turn = true;
                }
                // Else, try to assign from left bank
                else if let Some(Reverse((_, _))) = left_bank_wait_pq.peek() {
                    let Reverse((l_to_r_time, person_id)) = left_bank_wait_pq.pop().unwrap();
                    active_l_r_crossing.push(Reverse((current_time + l_to_r_time as i64, person_id)));
                    lanes_free -= 1;
                    assigned_this_turn = true;
                }

                if !assigned_this_turn {
                    break; // No one left to assign from waiting queues
                }
            }
        }

        last_person_finish_time
    }
}