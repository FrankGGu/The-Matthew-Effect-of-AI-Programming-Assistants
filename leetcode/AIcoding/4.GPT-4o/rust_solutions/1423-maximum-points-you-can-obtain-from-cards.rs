impl Solution {
    pub fn max_score(card_points: Vec<i32>, k: i32) -> i32 {
        let n = card_points.len();
        let k = k as usize;
        let mut total: i32 = card_points.iter().take(k).sum();
        let mut max_score = total;

        for i in 0..k {
            total += card_points[n - 1 - i] - card_points[k - 1 - i];
            max_score = max_score.max(total);
        }

        max_score
    }
}