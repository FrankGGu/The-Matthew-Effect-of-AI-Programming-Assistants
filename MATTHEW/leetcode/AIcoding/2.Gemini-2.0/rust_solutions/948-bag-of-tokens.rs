impl Solution {
    pub fn bag_of_tokens_score(tokens: Vec<i32>, power: i32) -> i32 {
        let mut tokens = tokens;
        tokens.sort();
        let mut score = 0;
        let mut left = 0;
        let mut right = tokens.len() - 1;
        let mut power = power;

        while left <= right {
            if power >= tokens[left] {
                power -= tokens[left];
                score += 1;
                left += 1;
            } else if score > 0 && left < right {
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