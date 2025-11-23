impl Solution {
    pub fn bag_of_tokens_score(tokens: Vec<i32>, power: i32) -> i32 {
        let mut tokens = tokens;
        tokens.sort();
        let (mut score, mut left, mut right) = (0, 0, tokens.len() as i32 - 1);

        while left <= right {
            if power >= tokens[left] {
                power -= tokens[left];
                score += 1;
                left += 1;
            } else if score > 0 {
                power += tokens[right];
                score -= 1;
                right -= 1;
            } else {
                break;
            }
        }

        score
    }
}