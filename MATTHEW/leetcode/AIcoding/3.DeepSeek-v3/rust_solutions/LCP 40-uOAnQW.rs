impl Solution {
    pub fn max_score(card_points: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = card_points.len();
        let mut total = 0;
        for &point in &card_points {
            total += point;
        }
        if k == n {
            return total;
        }
        let mut window_sum = 0;
        for i in 0..n - k {
            window_sum += card_points[i];
        }
        let mut min_window = window_sum;
        for i in n - k..n {
            window_sum += card_points[i] - card_points[i - (n - k)];
            min_window = min_window.min(window_sum);
        }
        total - min_window
    }
}