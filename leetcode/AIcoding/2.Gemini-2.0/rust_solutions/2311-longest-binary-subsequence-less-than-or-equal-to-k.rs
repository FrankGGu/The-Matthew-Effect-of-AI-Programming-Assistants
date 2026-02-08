impl Solution {
    pub fn longest_binary_subsequence(s: String, k: i32) -> i32 {
        let mut count = 0;
        let mut value = 0;
        let chars: Vec<char> = s.chars().collect();

        for &c in chars.iter().rev() {
            if c == '0' {
                count += 1;
            } else {
                if value + (1 << count) <= k {
                    value += 1 << count;
                    count += 1;
                }
            }
        }

        count as i32
    }
}