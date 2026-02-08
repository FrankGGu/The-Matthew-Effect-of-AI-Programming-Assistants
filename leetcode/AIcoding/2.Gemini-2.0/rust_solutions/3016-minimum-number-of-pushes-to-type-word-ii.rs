impl Solution {
    pub fn minimum_pushes(word: String) -> i32 {
        let mut counts = vec![0; 26];
        for c in word.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }
        counts.sort_by(|a, b| b.cmp(a));
        let mut ans = 0;
        for i in 0..counts.len() {
            if i < 8 {
                ans += counts[i];
            } else if i < 16 {
                ans += 2 * counts[i];
            } else if i < 24 {
                ans += 3 * counts[i];
            } else {
                ans += 4 * counts[i];
            }
        }
        ans
    }
}