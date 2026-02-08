impl Solution {
    pub fn good_indices(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let n = nums.len();
        let k = k as usize;
        let mut inc = vec![1; n];
        let mut dec = vec![1; n];
        let mut ans = Vec::new();

        for i in 1..n {
            if nums[i] <= nums[i - 1] {
                dec[i] = dec[i - 1] + 1;
            }
        }

        for i in (0..n - 1).rev() {
            if nums[i] <= nums[i + 1] {
                inc[i] = inc[i + 1] + 1;
            }
        }

        for i in k..n - k {
            if dec[i - 1] >= k as i32 && inc[i + 1] >= k as i32 {
                ans.push(i as i32);
            }
        }

        ans
    }
}