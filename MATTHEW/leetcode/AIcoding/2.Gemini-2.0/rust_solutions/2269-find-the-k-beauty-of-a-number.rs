impl Solution {
    pub fn divisor_substrings(num: i32, k: i32) -> i32 {
        let s = num.to_string();
        let mut count = 0;
        for i in 0..=s.len() - k as usize {
            let sub = &s[i..i + k as usize];
            let n = sub.parse::<i32>().unwrap();
            if n != 0 && num % n == 0 {
                count += 1;
            }
        }
        count
    }
}