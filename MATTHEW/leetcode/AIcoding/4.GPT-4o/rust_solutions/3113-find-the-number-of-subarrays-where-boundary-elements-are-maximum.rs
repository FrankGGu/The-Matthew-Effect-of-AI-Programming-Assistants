impl Solution {
    pub fn count_subarrays(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut ans = 0;
        let mut max_so_far = nums[0];
        let mut count = 0;

        for i in 0..n {
            if nums[i] > max_so_far {
                max_so_far = nums[i];
                count = 0;
            }
            count += 1;
            ans += count;
        }

        ans
    }
}