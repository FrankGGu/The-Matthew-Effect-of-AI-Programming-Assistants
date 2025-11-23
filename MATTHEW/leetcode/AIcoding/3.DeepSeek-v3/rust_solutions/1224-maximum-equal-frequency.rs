use std::collections::HashMap;

impl Solution {
    pub fn max_equal_freq(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        let mut count = HashMap::new();
        let mut res = 0;
        let mut max_freq = 0;

        for i in 0..nums.len() {
            let num = nums[i];
            let cnt = count.entry(num).or_insert(0);
            if *cnt > 0 {
                *freq.entry(*cnt).or_insert(0) -= 1;
            }
            *cnt += 1;
            *freq.entry(*cnt).or_insert(0) += 1;
            max_freq = max_freq.max(*cnt);

            let valid = max_freq == 1 ||
                *freq.get(&max_freq).unwrap_or(&0) == 1 && max_freq + (*freq.get(&(max_freq - 1)).unwrap_or(&0)) * (max_freq - 1) == (i + 1) ||
                *freq.get(&1).unwrap_or(&0) == 1 && max_freq * (*freq.get(&max_freq).unwrap_or(&0)) == i;

            if valid {
                res = i + 1;
            }
        }

        res as i32
    }
}