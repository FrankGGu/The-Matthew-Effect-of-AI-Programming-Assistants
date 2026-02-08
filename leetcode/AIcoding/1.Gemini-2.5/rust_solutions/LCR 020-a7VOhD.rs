impl Solution {
    pub fn count_substrings(s: String) -> i32 {
        let n = s.len();
        if n == 0 {
            return 0;
        }

        let chars: Vec<char> = s.chars().collect();
        let mut count = 0;

        let mut expand_and_count = |mut l: usize, mut r: usize| {
            let mut current_palindromes = 0;
            while l < n && r < n && chars[l] == chars[r] {
                current_palindromes += 1;
                if l == 0 {
                    break;
                }
                l -= 1;
                r += 1;
            }
            current_palindromes
        };

        for i in 0..n {
            count += expand_and_count(i, i);

            if i + 1 < n {
                count += expand_and_count(i, i + 1);
            }
        }

        count
    }
}