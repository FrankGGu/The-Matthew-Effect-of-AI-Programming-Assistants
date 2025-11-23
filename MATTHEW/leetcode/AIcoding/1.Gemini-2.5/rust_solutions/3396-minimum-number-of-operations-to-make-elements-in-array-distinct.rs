impl Solution {
    pub fn min_increment_for_unique(mut nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        nums.sort_unstable();

        let mut operations: i64 = 0;
        let mut prev = nums[0];

        for i in 1..nums.len() {
            let current = nums[i];
            if current <= prev {
                let target_val = prev + 1;
                operations += (target_val - current) as i64;
                prev = target_val;
            } else {
                prev = current;
            }
        }

        operations as i32
    }
}