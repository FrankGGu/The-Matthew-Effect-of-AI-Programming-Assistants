impl Solution {
    pub fn beauty_sum(s: String) -> i32 {
        let s = s.as_bytes();
        let mut res = 0;
        for i in 0..s.len() {
            let mut freq = [0; 26];
            for j in i..s.len() {
                freq[(s[j] - b'a') as usize] += 1;
                let max = *freq.iter().max().unwrap();
                let min = *freq.iter().filter(|&&x| x > 0).min().unwrap_or(&0);
                res += max - min;
            }
        }
        res
    }
}