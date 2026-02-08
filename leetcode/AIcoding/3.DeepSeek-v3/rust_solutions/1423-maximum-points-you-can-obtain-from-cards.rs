impl Solution {
    pub fn max_score(card_points: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = card_points.len();
        let total_sum: i32 = card_points.iter().sum();
        if k == n {
            return total_sum;
        }

        let window_size = n - k;
        let mut window_sum = card_points[..window_size].iter().sum::<i32>();
        let mut min_window_sum = window_sum;

        for i in window_size..n {
            window_sum += card_points[i] - card_points[i - window_size];
            if window_sum < min_window_sum {
                min_window_sum = window_sum;
            }
        }

        total_sum - min_window_sum
    }
}