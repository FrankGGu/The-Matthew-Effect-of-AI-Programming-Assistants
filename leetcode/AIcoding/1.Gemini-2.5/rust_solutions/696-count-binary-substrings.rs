impl Solution {
    pub fn count_binary_substrings(s: String) -> i32 {
        let n = s.len();
        if n == 0 {
            return 0;
        }

        let chars: Vec<char> = s.chars().collect();
        let mut ans = 0;
        let mut prev_count = 0;
        let mut curr_count = 1;

        for i in 1..n {
            if chars[i] == chars[i-1] {
                curr_count += 1;
            } else {
                ans += prev_count.min(curr_count);
                prev_count = curr_count;
                curr_count = 1;
            }
        }
        ans += prev_count.min(curr_count);

        ans
    }
}