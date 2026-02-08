use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn max_value_after_reverse(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut sum = 0;
        let mut min_max_diff = i32::MIN;
        let mut min_val = i32::MAX;
        let mut max_val = i32::MIN;

        for i in 0..n - 1 {
            let diff = (nums[i] - nums[i + 1]).abs();
            sum += diff;
            min_max_diff = min_max_diff.max(nums[i].min(nums[i + 1]) * 2);
            min_val = min_val.min(nums[i].max(nums[i + 1]));
            max_val = max_val.max(nums[i].min(nums[i + 1]));
        }

        let mut ans = sum + min_max_diff;

        ans = ans.max(sum + (nums[0] - nums[1]).abs() - (nums[n-2] - nums[n-1]).abs());
        ans = ans.max(sum + (nums[n-2] - nums[n-1]).abs() - (nums[0] - nums[1]).abs());
        ans = ans.max(sum + (nums[n-1] - nums[n-2]).abs() - (nums[1] - nums[0]).abs());
        ans = ans.max(sum + (nums[0] - nums[1]).abs() - (nums[n-1] - nums[n-2]).abs());

        ans = ans.max(sum + (nums[0] - nums[1]).abs() - (nums[n-1] - nums[n-2]).abs());
        ans = ans.max(sum + (nums[n-1] - nums[n-2]).abs() - (nums[0] - nums[1]).abs());

        ans = ans.max(sum + (nums[0] - nums[1]).abs() - (nums[n-1] - nums[n-2]).abs());
        ans = ans.max(sum + (nums[n-1] - nums[n-2]).abs() - (nums[0] - nums[1]).abs());
        ans = ans.max(sum + (nums[0] - nums[1]).abs() - (nums[n-1] - nums[n-2]).abs());
        ans = ans.max(sum + (nums[n-1] - nums[n-2]).abs() - (nums[0] - nums[1]).abs());

        let mut max_inc = 0;
        for i in 0..n - 1 {
            max_inc = max_inc.max((nums[0] - nums[i+1]).abs() - (nums[i]-nums[i+1]).abs());
            max_inc = max_inc.max((nums[n-1] - nums[i]).abs() - (nums[i]-nums[i+1]).abs());
        }

        for i in 1..n {
            max_inc = max_inc.max((nums[0] - nums[i-1]).abs() - (nums[i]-nums[i-1]).abs());
            max_inc = max_inc.max((nums[n-1] - nums[i]).abs() - (nums[i]-nums[i-1]).abs());
        }
        ans = ans.max(sum+max_inc);

        ans
    }
}