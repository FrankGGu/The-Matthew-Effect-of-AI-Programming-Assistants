impl Solution {
    pub fn maximum_score(a: i32, b: i32, c: i32) -> i32 {
        let mut scores = vec![a, b, c];
        scores.sort();
        let total = scores.iter().sum::<i32>();
        let max_score = scores[2];

        let half_total = total / 2;
        half_total.min(max_score)
    }
}