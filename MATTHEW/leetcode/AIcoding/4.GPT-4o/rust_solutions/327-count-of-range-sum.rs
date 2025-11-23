impl Solution {
    pub fn count_range_sum(nums: Vec<i32>, lower: i32, upper: i32) -> i32 {
        let n = nums.len();
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i];
        }
        Self::merge_sort(&mut prefix_sum, lower, upper)
    }

    fn merge_sort(prefix_sum: &mut Vec<i32>, lower: i32, upper: i32) -> i32 {
        if prefix_sum.len() <= 1 { return 0; }
        let mid = prefix_sum.len() / 2;
        let count = Self::merge_sort(&mut prefix_sum[..mid].to_vec(), lower, upper)
            + Self::merge_sort(&mut prefix_sum[mid..].to_vec(), lower, upper);

        let mut j = mid;
        let mut k = mid;
        for i in 0..mid {
            while j < prefix_sum.len() && prefix_sum[j] - prefix_sum[i] < lower {
                j += 1;
            }
            while k < prefix_sum.len() && prefix_sum[k] - prefix_sum[i] <= upper {
                k += 1;
            }
            count += (k - j) as i32;
        }

        let mut merged = vec![];
        let (mut left, mut right) = (0, mid);
        while left < mid && right < prefix_sum.len() {
            if prefix_sum[left] <= prefix_sum[right] {
                merged.push(prefix_sum[left]);
                left += 1;
            } else {
                merged.push(prefix_sum[right]);
                right += 1;
            }
        }
        while left < mid {
            merged.push(prefix_sum[left]);
            left += 1;
        }
        while right < prefix_sum.len() {
            merged.push(prefix_sum[right]);
            right += 1;
        }

        prefix_sum[..merged.len()].copy_from_slice(&merged);
        count
    }
}