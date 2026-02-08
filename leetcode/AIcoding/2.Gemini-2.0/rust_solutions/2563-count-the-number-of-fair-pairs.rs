impl Solution {
    pub fn count_fair_pairs(nums: Vec<i32>, lower: i32, upper: i32) -> i64 {
        let mut nums = nums;
        nums.sort();
        let mut count: i64 = 0;
        for i in 0..nums.len() {
            let lower_bound = lower - nums[i];
            let upper_bound = upper - nums[i];

            let lower_idx = match nums[i+1..].binary_search(&lower_bound) {
                Ok(idx) => idx + i + 1,
                Err(idx) => idx + i + 1,
            };

            let upper_idx = match nums[i+1..].binary_search(&upper_bound) {
                Ok(idx) => {
                    let mut temp_idx = idx + i + 1;
                    while temp_idx + 1 < nums.len() && nums[temp_idx + 1] == upper_bound {
                        temp_idx += 1;
                    }
                    temp_idx + 1
                },
                Err(idx) => idx + i + 1,
            };

            count += (upper_idx as i64 - lower_idx as i64).max(0);
        }
        count
    }
}