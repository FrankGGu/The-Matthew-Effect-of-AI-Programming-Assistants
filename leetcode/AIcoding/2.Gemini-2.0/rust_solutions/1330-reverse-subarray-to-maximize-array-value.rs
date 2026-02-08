impl Solution {
    pub fn max_value_after_reverse(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut sum = 0;
        let mut min_max = i32::MIN;
        let mut extra = 0;

        for i in 0..n - 1 {
            let a = nums[i];
            let b = nums[i + 1];
            sum += (a - b).abs();
            min_max = min_max.max((a.min(b)));
            extra = extra.max((a + b).abs());
        }

        let mut ans = sum;

        ans = ans.max(sum + 2 * min_max);

        ans = ans.max(sum + extra);
        ans
    }
}