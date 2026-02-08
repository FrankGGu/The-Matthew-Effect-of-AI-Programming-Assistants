impl Solution {
    pub fn number_of_winning_players(scores: Vec<i32>, k: i32) -> i32 {
        let mut scores = scores;
        scores.sort_unstable_by(|a, b| b.cmp(a));
        let mut res = 0;
        let mut count = 0;
        let mut prev = i32::MAX;

        for &score in &scores {
            if score < prev {
                if count >= k {
                    break;
                }
                prev = score;
            }
            res += 1;
            count += 1;
        }

        res
    }
}