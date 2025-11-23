impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn check_arithmetic_subarray(nums: Vec<i32>, l: Vec<i32>, r: Vec<i32>) -> Vec<bool> {
        let mut result = Vec::new();
        for i in 0..l.len() {
            let left = l[i] as usize;
            let right = r[i] as usize;
            let sub = &nums[left..=right];
            let mut unique = HashSet::new();
            let mut min_val = i32::MAX;
            let mut max_val = i32::MIN;
            for &num in sub {
                unique.insert(num);
                min_val = min_val.min(num);
                max_val = max_val.max(num);
            }
            if unique.len() == 1 {
                result.push(true);
                continue;
            }
            let diff = (max_val - min_val) as f64;
            let n = sub.len() as f64;
            let expected_diff = diff / (n - 1.0);
            let mut is_arithmetic = true;
            for &num in sub {
                let expected = min_val + (num - min_val) as f64 / (n - 1.0) * diff;
                if (num as f64 - expected).abs() > 1e-9 {
                    is_arithmetic = false;
                    break;
                }
            }
            result.push(is_arithmetic);
        }
        result
    }
}
}