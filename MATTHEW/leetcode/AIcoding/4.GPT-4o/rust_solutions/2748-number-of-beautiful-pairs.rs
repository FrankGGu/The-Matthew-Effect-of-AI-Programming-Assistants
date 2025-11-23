impl Solution {
    pub fn count_beautiful_pairs(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let n = nums.len();
        for i in 0..n {
            for j in 0..n {
                if i != j && (nums[i] - nums[j]).abs() == 1 {
                    count += 1;
                }
            }
        }
        count
    }
}