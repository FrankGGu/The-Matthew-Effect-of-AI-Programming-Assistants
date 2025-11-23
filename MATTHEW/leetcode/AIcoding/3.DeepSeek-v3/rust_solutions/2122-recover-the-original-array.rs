use std::collections::HashMap;

impl Solution {
    pub fn recover_array(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums;
        nums.sort_unstable();
        let n = nums.len();

        for i in 1..n {
            let diff = nums[i] - nums[0];
            if diff == 0 || diff % 2 != 0 {
                continue;
            }
            let k = diff / 2;
            let mut freq = HashMap::new();
            for &num in &nums {
                *freq.entry(num).or_insert(0) += 1;
            }
            let mut res = Vec::new();
            let mut valid = true;
            for &num in &nums {
                if *freq.get(&num).unwrap_or(&0) == 0 {
                    continue;
                }
                if *freq.get(&(num + 2 * k)).unwrap_or(&0) == 0 {
                    valid = false;
                    break;
                }
                *freq.get_mut(&num).unwrap() -= 1;
                *freq.get_mut(&(num + 2 * k)).unwrap() -= 1;
                res.push(num + k);
            }
            if valid {
                return res;
            }
        }
        vec![]
    }
}