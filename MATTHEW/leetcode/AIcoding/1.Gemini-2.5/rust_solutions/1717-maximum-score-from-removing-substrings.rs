impl Solution {
    pub fn maximum_score(s: String, x: i32, y: i32) -> i32 {
        let mut total_score = 0;
        let mut remaining_s = s;

        if x >= y {
            // Prioritize "ab"
            let (s_after_ab, score_ab) = Self::solve_for_pair(&remaining_s, 'a', 'b', x);
            total_score += score_ab;
            remaining_s = s_after_ab;

            // Then remove "ba" from the remaining string
            let (_, score_ba) = Self::solve_for_pair(&remaining_s, 'b', 'a', y);
            total_score += score_ba;
        } else {
            // Prioritize "ba"
            let (s_after_ba, score_ba) = Self::solve_for_pair(&remaining_s, 'b', 'a', y);
            total_score += score_ba;
            remaining_s = s_after_ba;

            // Then remove "ab" from the remaining string
            let (_, score_ab) = Self::solve_for_pair(&remaining_s, 'a', 'b', x);
            total_score += score_ab;
        }

        total_score
    }

    fn solve_for_pair(s: &str, char1: char, char2: char, score_per_pair: i32) -> (String, i32) {
        let mut stack: Vec<char> = Vec::new();
        let mut current_score = 0;

        for c in s.chars() {
            if c == char2 && !stack.is_empty() && *stack.last().unwrap() == char1 {
                stack.pop();
                current_score += score_per_pair;
            } else {
                stack.push(c);
            }
        }

        (stack.into_iter().collect(), current_score)
    }
}