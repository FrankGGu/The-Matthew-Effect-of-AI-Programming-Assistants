impl Solution {
    pub fn good_days_to_rob_the_bank(security: Vec<i32>, time: i32) -> Vec<i32> {
        let n = security.len();
        let time = time as usize;

        if time == 0 {
            return (0..n as i32).collect();
        }

        if n < 2 * time + 1 {
            return Vec::new();
        }

        let mut left_non_increasing = vec![1; n];
        for i in 1..n {
            if security[i - 1] >= security[i] {
                left_non_increasing[i] = left_non_increasing[i - 1] + 1;
            }
        }

        let mut right_non_decreasing = vec![1; n];
        for i in (0..n - 1).rev() {
            if security[i] <= security[i + 1] {
                right_non_decreasing[i] = right_non_decreasing[i + 1] + 1;
            }
        }

        let mut result = Vec::new();
        for i in time..=(n - 1 - time) {
            if left_non_increasing[i] >= time + 1 && right_non_decreasing[i] >= time + 1 {
                result.push(i as i32);
            }
        }

        result
    }
}