impl Solution {
    pub fn find_best_value(arr: Vec<i32>, target: i32) -> i32 {
        let mut left = 0;
        let mut right = *arr.iter().max().unwrap();
        let n = arr.len();

        while left < right {
            let mid = (left + right) / 2;
            let sum: i32 = arr.iter().map(|&x| if x > mid { mid } else { x }).sum();

            if sum > target {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        let sum_left: i32 = arr.iter().map(|&x| if x > left - 1 { left - 1 } else { x }).sum();
        let sum_right: i32 = arr.iter().map(|&x| if x > left { left } else { x }).sum();

        if (sum_left - target).abs() <= (sum_right - target).abs() {
            left - 1
        } else {
            left
        }
    }
}