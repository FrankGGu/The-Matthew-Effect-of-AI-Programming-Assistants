impl Solution {
    pub fn bag_of_tokens_score(mut tokens: Vec<i32>, mut power: i32) -> i32 {
        tokens.sort_unstable();

        let n = tokens.len();
        if n == 0 {
            return 0;
        }

        let mut left = 0;
        let mut right = n - 1;
        let mut score = 0;
        let mut max_score = 0;

        while left <= right {
            if power >= tokens[left] {
                // Play face up: gain score, lose power
                power -= tokens[left];
                score += 1;
                left += 1;
                max_score = max_score.max(score);
            } else if score >= 1 && left < right {
                // Play face down: lose score, gain power
                // Only if we have score and there are other tokens to potentially play
                power += tokens[right];
                score -= 1;
                right -= 1;
            } else {
                // Cannot make any more beneficial moves
                break;
            }
        }

        max_score
    }
}