impl Solution {
    pub fn max_value_after_reverse(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut original = 0;
        for i in 0..n - 1 {
            original += (nums[i] - nums[i + 1]).abs();
        }

        let mut max_gain = 0;

        // Case 1: reverse a prefix or suffix
        for i in 0..n - 1 {
            let gain = (nums[0] - nums[i + 1]).abs() - (nums[i] - nums[i + 1]).abs();
            max_gain = max_gain.max(gain);
        }
        for i in 0..n - 1 {
            let gain = (nums[i] - nums[n - 1]).abs() - (nums[i] - nums[i + 1]).abs();
            max_gain = max_gain.max(gain);
        }

        // Case 2: reverse a subarray in the middle
        let (mut max1, mut min2) = (i32::MIN, i32::MAX);
        for i in 0..n - 1 {
            let a = nums[i];
            let b = nums[i + 1];
            max1 = max1.max(a.min(b));
            min2 = min2.min(a.max(b));
        }
        let gain = 2 * (max1 - min2);
        max_gain = max_gain.max(gain);

        original + max_gain
    }
}