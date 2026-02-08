impl Solution {
    pub fn min_steps(s: String, t: String) -> i32 {
        let mut count = [0; 26];
        for ch in s.chars() {
            count[ch as usize - 'a' as usize] += 1;
        }
        for ch in t.chars() {
            count[ch as usize - 'a' as usize] -= 1;
        }
        count.iter().filter(|&&x| x > 0).sum()
    }
}