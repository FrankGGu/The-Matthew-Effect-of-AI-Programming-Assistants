impl Solution {
    pub fn find_best_value(arr: Vec<i32>, target: i32) -> i32 {
        let mut arr = arr;
        arr.sort();
        let n = arr.len();
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + arr[i];
        }

        let mut low = 0;
        let mut high = arr[n - 1];
        let mut best_value = 0;
        let mut min_diff = i32::MAX;

        while low <= high {
            let mid = low + (high - low) / 2;
            let mut sum = 0;
            let mut index = 0;
            for i in 0..n {
                if arr[i] > mid {
                    index = i;
                    break;
                }
            }

            sum = prefix_sum[index] + (n - index) as i32 * mid;
            let diff = (sum - target as i32).abs();

            if diff < min_diff {
                min_diff = diff;
                best_value = mid;
            } else if diff == min_diff && mid < best_value {
                best_value = mid;
            }

            if sum < target as i32 {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        best_value
    }
}