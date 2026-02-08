impl Solution {
    pub fn find_best_value(arr: Vec<i32>, target: i32) -> i32 {
        let mut left = 0;
        let mut right = *arr.iter().max().unwrap();
        let mut best_diff = i32::MAX;
        let mut best_value = 0;

        while left <= right {
            let mid = left + (right - left) / 2;
            let sum = arr.iter().map(|&x| if x > mid { mid } else { x }).sum::<i32>();
            let diff = (sum - target).abs();

            if diff < best_diff || (diff == best_diff && mid < best_value) {
                best_diff = diff;
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