impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        for i in 0..nums.len() {
            let mut current_and = nums[i];
            if current_and == k {
                count += 1;
            }
            for j in i + 1..nums.len() {
                current_and &= nums[j];
                if current_and == k {
                    count += 1;
                }
            }
        }
        count
    }
}