use std::collections::HashSet;

impl Solution {
    pub fn longest_square_streak(nums: Vec<i32>) -> i32 {
        let num_set: HashSet<_> = nums.iter().cloned().collect();
        let mut max_streak = 0;

        for &num in nums.iter() {
            let mut current = num;
            let mut streak = 1;

            while let Some(next) = num_set.get(&(current * current)) {
                current = *next;
                streak += 1;
            }

            if streak > max_streak {
                max_streak = streak;
            }
        }

        if max_streak >= 2 {
            max_streak
        } else {
            -1
        }
    }
}