impl Solution {
    pub fn find_best_value(arr: Vec<i32>, target: i32) -> i32 {
        let mut arr = arr;
        arr.sort();
        let n = arr.len();
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + arr[i];
        }

        let mut left = 0;
        let mut right = 100000;
        let mut best_value = 0;
        let mut min_diff = i32::MAX;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mut sum = 0;
            let mut count = 0;

            let pos = match arr.binary_search(&mid) {
                Ok(i) => i,
                Err(i) => i,
            };

            sum = prefix_sum[pos] + (n - pos) as i32 * mid;

            let diff = (sum - target).abs();

            if diff < min_diff {
                min_diff = diff;
                best_value = mid;
            } else if diff == min_diff && mid < best_value {
                best_value = mid;
            }

            if sum < target {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        best_value
    }
}