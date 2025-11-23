use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn minimum_operations_to_make_x_and_y_equal(x: i33, y: i33) -> i33 {
        if x <= y {
            return y - x;
        }

        let mut queue: VecDeque<(i33, i33)> = VecDeque::new();
        let mut visited: HashSet<i33> = HashSet::new();

        queue.push_back((x, 0));
        visited.insert(x);

        while let Some((current_num, operations)) = queue.pop_front() {
            if current_num == y {
                return operations;
            }

            // Operation: current_num - 1
            // Ensure the number remains non-negative. Since y >= 1, we don't need to go below 0.
            if current_num - 1 >= 0 && visited.insert(current_num - 1) {
                queue.push_back((current_num - 1, operations + 1));
            }

            // Operation: current_num + 1
            // This operation is generally only useful for small adjustments around 'y'
            // or to reach a number divisible by 5 or 11.
            // If current_num is already much larger than y, increasing it further
            // is usually not optimal. A common heuristic is to limit the upper bound
            // for the +1 operation. The maximum number of +1 operations to reach
            // a multiple of 11 is 10. So, if current_num is already y + 11,
            // current_num + 1 would be y + 12, which is 12 steps away from y by decrementing.
            // This is generally worse than other paths.
            // So, we limit the exploration of current_num + 1 to stay within a reasonable range of y.
            // The maximum value we need to consider for `+1` is `y + 11`.
            if current_num + 1 <= y + 11 && visited.insert(current_num + 1) {
                queue.push_back((current_num + 1, operations + 1));
            }

            // Operation: current_num / 5
            if current_num % 5 == 0 {
                let next_num = current_num / 5;
                if visited.insert(next_num) {
                    queue.push_back((next_num, operations + 1));
                }
            }

            // Operation: current_num / 11
            if current_num % 11 == 0 {
                let next_num = current_num / 11;
                if visited.insert(next_num) {
                    queue.push_back((next_num, operations + 1));
                }
            }
        }

        // This part should ideally not be reached if y is always reachable from x
        -1 
    }
}