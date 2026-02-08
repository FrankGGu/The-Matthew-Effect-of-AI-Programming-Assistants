impl Solution {
    pub fn lexicographically_smallest_string_after_a_swap(s: String) -> String {
        let n = s.len();
        let mut min_s = s.clone();
        let original_chars: Vec<char> = s.chars().collect();

        for i in 0..n {
            for j in (i + 1)..n {
                let mut current_chars = original_chars.clone();
                current_chars.swap(i, j);
                let current_string: String = current_chars.iter().collect();

                if current_string < min_s {
                    min_s = current_string;
                }
            }
        }

        min_s
    }
}