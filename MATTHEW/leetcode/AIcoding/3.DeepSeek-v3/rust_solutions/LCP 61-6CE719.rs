impl Solution {
    pub fn temperature_trend(temperature_a: Vec<i32>, temperature_b: Vec<i32>) -> i32 {
        let n = temperature_a.len();
        let mut max_len = 0;
        let mut current_len = 0;

        for i in 1..n {
            let trend_a = temperature_a[i] - temperature_a[i - 1];
            let trend_b = temperature_b[i] - temperature_b[i - 1];

            if (trend_a > 0 && trend_b > 0) || 
               (trend_a < 0 && trend_b < 0) || 
               (trend_a == 0 && trend_b == 0) {
                current_len += 1;
                if current_len > max_len {
                    max_len = current_len;
                }
            } else {
                current_len = 0;
            }
        }

        max_len
    }
}