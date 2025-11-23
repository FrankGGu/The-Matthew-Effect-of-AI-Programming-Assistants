use std::collections::{HashSet, HashMap};

impl Solution {
    pub fn longest_square_streak(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable(); 

        let num_set: HashSet<i32> = nums.iter().cloned().collect();
        let mut dp: HashMap<i32, i32> = HashMap::new(); 

        let mut max_overall_streak = 0;

        for &num in nums.iter() {
            dp.insert(num, 1); 

            let num_i64 = num as i64;
            let prev_num_f64 = (num_i64 as f64).sqrt();
            let prev_num_i64 = prev_num_f64 as i64;

            if prev_num_i64 * prev_num_i64 == num_i64 && prev_num_i64 < num_i64 {
                let prev_num = prev_num_i64 as i32;

                if num_set.contains(&prev_num) {
                    if let Some(&prev_streak) = dp.get(&prev_num) {
                        dp.insert(num, prev_streak + 1);
                    }
                }
            }

            max_overall_streak = max_overall_streak.max(*dp.get(&num).unwrap());
        }

        if max_overall_streak <= 1 {
            -1
        } else {
            max_overall_streak
        }
    }
}