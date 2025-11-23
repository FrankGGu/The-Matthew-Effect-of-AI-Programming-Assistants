impl Solution {
    pub fn find_the_longest_balanced_substring(s: String) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut max_len = 0;
        for i in 0..n {
            for j in i + 1..=n {
                let sub = &s[i..j];
                let len = sub.len();
                let zeros = sub.iter().filter(|&c| *c == '0').count();
                let ones = sub.iter().filter(|&c| *c == '1').count();
                if zeros == ones && (zeros + ones) == len {
                    max_len = max_len.max(len as i32);
                }

            }
        }
        max_len
    }
}