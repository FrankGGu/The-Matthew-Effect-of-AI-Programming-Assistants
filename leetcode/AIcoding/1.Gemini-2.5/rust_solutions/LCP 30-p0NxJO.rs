use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn magic_tower(nums: Vec<i32>) -> i64 {
        let total_sum: i64 = nums.iter().map(|&x| x as i64).sum();

        // If the total sum of health changes is negative, it's impossible to pass all rooms
        // because health will eventually drop below 1 and stay there.
        if total_sum < 0 {
            return -1;
        }

        // `current_health` tracks the sum of health changes from rooms processed so far
        // in the current (potentially reordered) sequence.
        let mut current_health: i64 = 0;

        // `initial_health_needed` tracks the minimum additional health required to start with
        // to ensure health never drops below 1 for the processed rooms.
        // It starts at 0, meaning we initially assume 1 health is enough.
        let mut initial_health_needed: i64 = 0;

        // `pq` is a min-priority queue to store negative health changes.
        // We use `Reverse<i32>` with `BinaryHeap` to simulate a min-heap.
        let mut pq: BinaryHeap<Reverse<i32>> = BinaryHeap::new();

        for &num in nums.iter() {
            current_health += num as i64;

            // If the current room reduces health, add it to the priority queue.
            if num < 0 {
                pq.push(Reverse(num));
            }

            // If `current_health` drops below `initial_health_needed`, it means
            // `(initial_health_needed_base + current_health_sum) < 1`.
            // We need to increase our initial health.
            // To do this, we "postpone" the most damaging (smallest) negative health change
            // encountered so far. By postponing it, we remove its effect from `current_health`
            // and add its absolute value to `initial_health_needed`.
            while current_health < initial_health_needed {
                if let Some(Reverse(val)) = pq.pop() {
                    // Undo the effect of the postponed room from `current_health`.
                    current_health -= val as i64;
                    // Add the absolute value of the postponed room to `initial_health_needed`.
                    // This means this amount must be covered by the starting health.
                    initial_health_needed += -val as i64;
                } else {
                    // This case should ideally not be reached if total_sum >= 0,
                    // as it implies an unrecoverable deficit without any negative rooms to postpone.
                    // However, it's good practice to handle.
                    break;
                }
            }
        }

        // The total minimum initial health required is `initial_health_needed` (to cover postponed rooms)
        // plus 1 (to ensure health is always strictly greater than 0).
        initial_health_needed + 1
    }
}