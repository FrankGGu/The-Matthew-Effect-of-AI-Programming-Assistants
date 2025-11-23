impl Solution {
    pub fn find_largest_outlier(nums: Vec<i32>) -> i32 {
        let mut sorted_nums = nums.clone();
        sorted_nums.sort();
        let n = sorted_nums.len();

        if n < 3 {
            return sorted_nums[n - 1];
        }

        let q1 = sorted_nums[n / 4];
        let q3 = sorted_nums[3 * n / 4];
        let iqr = q3 - q1;
        let lower_bound = q1 - 3 * iqr;
        let upper_bound = q3 + 3 * iqr;

        let mut largest_outlier = i32::MIN;

        for &num in &nums {
            if num < lower_bound || num > upper_bound {
                largest_outlier = largest_outlier.max(num);
            }
        }

        if largest_outlier == i32::MIN {
            return sorted_nums[n-1];
        }

        largest_outlier
    }
}