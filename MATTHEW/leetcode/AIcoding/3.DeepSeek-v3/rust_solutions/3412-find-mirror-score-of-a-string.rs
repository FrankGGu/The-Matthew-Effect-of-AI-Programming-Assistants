impl Solution {
    pub fn find_mirror_score(s: String) -> i32 {
        let mut score = 0;
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        let mut left = 0;
        let mut right = n - 1;

        while left <= right {
            if chars[left] == chars[right] {
                score += if left == right { 1 } else { 2 };
            }
            left += 1;
            right -= 1;
        }

        score
    }
}