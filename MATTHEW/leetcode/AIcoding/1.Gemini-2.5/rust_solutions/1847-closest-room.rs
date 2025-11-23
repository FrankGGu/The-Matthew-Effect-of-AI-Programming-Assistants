use std::collections::BTreeSet;

impl Solution {
    pub fn closest_room(rooms: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut rooms_processed: Vec<(i32, i32)> = rooms.into_iter().map(|r| (r[1], r[0])).collect(); // (size, id)
        rooms_processed.sort_unstable_by(|a, b| b.0.cmp(&a.0)); // Sort by size descending

        let mut queries_processed: Vec<(i32, i32, usize)> = queries
            .into_iter()
            .enumerate()
            .map(|(i, q)| (q[1], q[0], i)) // (min_size, preferred_id, original_index)
            .collect();
        queries_processed.sort_unstable_by(|a, b| b.0.cmp(&a.0)); // Sort by min_size descending

        let mut results = vec![-1; queries_processed.len()];
        let mut available_room_ids = BTreeSet::new();
        let mut room_idx = 0;

        for (q_min_size, q_preferred_id, q_original_idx) in queries_processed {
            while room_idx < rooms_processed.len() && rooms_processed[room_idx].0 >= q_min_size {
                available_room_ids.insert(rooms_processed[room_idx].1);
                room_idx += 1;
            }

            if available_room_ids.is_empty() {
                continue;
            }

            let mut best_room_id = -1;
            let mut min_diff = i32::MAX;

            if let Some(&id) = available_room_ids.range(..=q_preferred_id).rev().next() {
                let diff = q_preferred_id - id;
                min_diff = diff;
                best_room_id = id;
            }

            if let Some(&id) = available_room_ids.range(q_preferred_id..).next() {
                let diff = id - q_preferred_id;
                if diff < min_diff {
                    min_diff = diff;
                    best_room_id = id;
                } else if diff == min_diff {
                    if id < best_room_id {
                        best_room_id = id;
                    }
                }
            }

            results[q_original_idx] = best_room_id;
        }

        results
    }
}