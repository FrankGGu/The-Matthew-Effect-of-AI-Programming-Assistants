impl Solution {
    pub fn get_max_repetitions(s1: String, n1: i32, s2: String, n2: i32) -> i32 {
        let s1_chars: Vec<char> = s1.chars().collect();
        let s2_chars: Vec<char> = s2.chars().collect();
        let len1 = s1_chars.len();
        let len2 = s2_chars.len();
        let mut index = 0;
        let mut count = 0;
        let mut dp = vec![None; len2 + 1];
        let mut k = 0;

        while k < n1 {
            for i in 0..len1 {
                if s1_chars[i] == s2_chars[index] {
                    index += 1;
                    if index == len2 {
                        index = 0;
                        count += 1;
                    }
                }
            }
            k += 1;

            if let Some((prev_k, prev_count)) = dp[index] {
                let cycle = (n1 - k) / (k - prev_k);
                count += cycle * (count - prev_count);
                k += cycle * (k - prev_k);
            } else {
                dp[index] = Some((k, count));
            }
        }

        count / n2
    }
}