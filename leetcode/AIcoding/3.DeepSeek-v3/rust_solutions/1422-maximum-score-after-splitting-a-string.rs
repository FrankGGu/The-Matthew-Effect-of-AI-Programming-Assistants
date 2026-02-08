impl Solution {
    pub fn max_score(s: String) -> i32 {
        let chars: Vec<char> = s.chars().collect();
        let mut max_score = 0;
        let total_ones = chars.iter().filter(|&&c| c == '1').count() as i32;

        let mut left_zeros = 0;
        let mut right_ones = total_ones;

        for i in 0..chars.len() - 1 {
            if chars[i] == '0' {
                left_zeros += 1;
            } else {
                right_ones -= 1;
            }
            let current_score = left_zeros + right_ones;
            if current_score > max_score {
                max_score = current_score;
            }
        }

        max_score
    }
}