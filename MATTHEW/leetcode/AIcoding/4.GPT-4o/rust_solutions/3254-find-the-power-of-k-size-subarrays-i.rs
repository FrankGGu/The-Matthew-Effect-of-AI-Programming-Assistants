impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let n = nums.len();
        for i in 0..n {
            let mut product = 1;
            for j in i..n {
                product *= nums[j];
                if product == k {
                    count += 1;
                }
                if product > k {
                    break;
                }
            }
        }
        count
    }
}