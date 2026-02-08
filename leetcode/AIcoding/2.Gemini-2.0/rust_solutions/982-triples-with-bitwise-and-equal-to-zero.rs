impl Solution {
    pub fn count_triplets(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        for i in 0..nums.len() {
            for j in 0..nums.len() {
                for k in 0..nums.len() {
                    if (nums[i] & nums[j] & nums[k]) == 0 {
                        count += 1;
                    }
                }
            }
        }
        count
    }
}