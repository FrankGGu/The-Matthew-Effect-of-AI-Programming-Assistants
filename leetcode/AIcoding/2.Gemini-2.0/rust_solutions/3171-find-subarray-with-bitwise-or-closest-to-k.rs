impl Solution {
    pub fn find_subarray_with_bitwise_or_closest_to_k(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut ans = i32::MAX;
        for i in 0..n {
            let mut curr_or = 0;
            for j in i..n {
                curr_or |= nums[j];
                ans = ans.min((curr_or - k).abs());
            }
        }
        ans
    }
}