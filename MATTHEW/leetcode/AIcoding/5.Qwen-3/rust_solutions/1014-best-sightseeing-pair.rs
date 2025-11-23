pub fn max_score_sightseeing(s: String) -> i32 {
    let s = s.as_bytes();
    let mut max_score = 0;
    let mut prev = s[0] as i32 - 1;

    for i in 1..s.len() {
        let current = s[i] as i32 - 1;
        max_score = max_score.max(prev + current);
        prev = prev.max(current);
    }

    max_score
}