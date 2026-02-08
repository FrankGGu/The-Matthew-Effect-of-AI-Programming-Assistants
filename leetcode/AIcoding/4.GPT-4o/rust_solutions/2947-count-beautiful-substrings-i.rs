impl Solution {
    pub fn count_beautiful_substrings(s: String) -> i32 {
        let mut count = 0;
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();

        for i in 0..n {
            for j in i..n {
                let substring = &chars[i..=j];
                if substring.iter().all(|&c| c == '1') || substring.iter().all(|&c| c == '0') {
                    count += 1;
                }
            }
        }

        count
    }
}