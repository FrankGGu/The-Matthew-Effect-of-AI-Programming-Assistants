impl Solution {
    pub fn moves_to_make_zigzag(nums: Vec<i32>) -> i32 {
        let mut res1 = 0;
        let mut res2 = 0;
        let n = nums.len();

        for i in 0..n {
            let left = if i > 0 { nums[i - 1] } else { i32::MAX };
            let right = if i < n - 1 { nums[i + 1] } else { i32::MAX };
            let min = left.min(right);

            if i % 2 == 1 {
                if nums[i] >= min {
                    res1 += nums[i] - min + 1;
                }
            } else {
                if nums[i] >= min {
                    res2 += nums[i] - min + 1;
                }
            }
        }

        res1.min(res2)
    }
}