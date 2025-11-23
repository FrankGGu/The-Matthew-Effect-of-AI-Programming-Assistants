use std::collections::HashSet;

impl Solution {
    pub fn min_abs_difference(arr: Vec<i32>, goal: i32) -> i32 {
        let n = arr.len();
        let mut first_half = HashSet::new();
        let mut second_half = HashSet::new();

        for i in 0..1 << (n / 2) {
            let mut sum = 0;
            for j in 0..(n / 2) {
                if i & (1 << j) != 0 {
                    sum += arr[j];
                }
            }
            first_half.insert(sum);
        }

        for i in 0..1 << (n - n / 2) {
            let mut sum = 0;
            for j in 0..(n - n / 2) {
                if i & (1 << j) != 0 {
                    sum += arr[n / 2 + j];
                }
            }
            second_half.insert(sum);
        }

        let mut closest_sum = i32::MAX;

        for &sum1 in &first_half {
            for &sum2 in &second_half {
                let total = sum1 + sum2;
                closest_sum = closest_sum.min((total - goal).abs());
            }
        }

        closest_sum
    }
}