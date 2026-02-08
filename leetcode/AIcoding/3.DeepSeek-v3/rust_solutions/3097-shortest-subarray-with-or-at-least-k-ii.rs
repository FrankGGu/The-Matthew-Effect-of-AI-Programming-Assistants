impl Solution {
    pub fn shortest_subarray(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut res = n + 1;
        let mut or = 0;
        let mut left = 0;

        for right in 0..n {
            or |= nums[right];

            while or >= k && left <= right {
                res = res.min(right - left + 1);
                let mut temp_or = 0;
                for i in left + 1..=right {
                    temp_or |= nums[i];
                }
                or = temp_or;
                left += 1;
            }
        }

        if res <= n { res as i32 } else { -1 }
    }
}