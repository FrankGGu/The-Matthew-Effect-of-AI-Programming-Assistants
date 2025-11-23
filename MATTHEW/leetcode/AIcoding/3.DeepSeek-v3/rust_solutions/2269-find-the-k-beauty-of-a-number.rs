impl Solution {
    pub fn divisor_substrings(num: i32, k: i32) -> i32 {
        let s = num.to_string();
        let k = k as usize;
        let mut count = 0;
        for i in 0..=s.len().saturating_sub(k) {
            let substring = &s[i..i + k];
            if let Ok(n) = substring.parse::<i32>() {
                if n != 0 && num % n == 0 {
                    count += 1;
                }
            }
        }
        count
    }
}