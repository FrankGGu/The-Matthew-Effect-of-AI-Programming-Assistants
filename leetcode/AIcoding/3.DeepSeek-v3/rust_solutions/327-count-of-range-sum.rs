impl Solution {
    pub fn count_range_sum(nums: Vec<i32>, lower: i32, upper: i32) -> i32 {
        let n = nums.len();
        let mut sum = vec![0; n + 1];
        for i in 0..n {
            sum[i + 1] = sum[i] + nums[i] as i64;
        }
        let mut helper = vec![0; n + 1];
        Self::merge_sort(&mut sum, &mut helper, 0, n, lower as i64, upper as i64)
    }

    fn merge_sort(sum: &mut Vec<i64>, helper: &mut Vec<i64>, left: usize, right: usize, lower: i64, upper: i64) -> i32 {
        if left >= right {
            return 0;
        }
        let mid = left + (right - left) / 2;
        let mut count = Self::merge_sort(sum, helper, left, mid, lower, upper)
            + Self::merge_sort(sum, helper, mid + 1, right, lower, upper);
        let mut i = left;
        let mut j = mid + 1;
        let mut k = mid + 1;
        while i <= mid {
            while j <= right && sum[j] - sum[i] < lower {
                j += 1;
            }
            while k <= right && sum[k] - sum[i] <= upper {
                k += 1;
            }
            count += (k - j) as i32;
            i += 1;
        }
        Self::merge(sum, helper, left, mid, right);
        count
    }

    fn merge(sum: &mut Vec<i64>, helper: &mut Vec<i64>, left: usize, mid: usize, right: usize) {
        for i in left..=right {
            helper[i] = sum[i];
        }
        let mut i = left;
        let mut j = mid + 1;
        let mut k = left;
        while i <= mid && j <= right {
            if helper[i] <= helper[j] {
                sum[k] = helper[i];
                i += 1;
            } else {
                sum[k] = helper[j];
                j += 1;
            }
            k += 1;
        }
        while i <= mid {
            sum[k] = helper[i];
            i += 1;
            k += 1;
        }
    }
}