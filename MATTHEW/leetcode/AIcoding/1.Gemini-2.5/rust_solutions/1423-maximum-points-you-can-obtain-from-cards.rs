impl Solution {
    pub fn max_score(card_points: Vec<i32>, k: i32) -> i32 {
        let n = card_points.len();
        let k_usize = k as usize;

        let mut current_score: i32 = 0;

        for i in 0..k_usize {
            current_score += card_points[i];
        }

        let mut max_score = current_score;

        for i in 0..k_usize {
            current_score -= card_points[k_usize - 1 - i];
            current_score += card_points[n - 1 - i];
            max_score = max_score.max(current_score);
        }

        max_score
    }
}