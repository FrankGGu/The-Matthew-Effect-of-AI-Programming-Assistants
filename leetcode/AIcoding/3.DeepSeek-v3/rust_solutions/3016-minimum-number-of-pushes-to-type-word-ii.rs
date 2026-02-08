impl Solution {
    pub fn minimum_pushes(word: String) -> i32 {
        let mut freq = [0; 26];
        for c in word.chars() {
            freq[(c as u8 - b'a') as usize] += 1;
        }
        freq.sort_unstable_by(|a, b| b.cmp(a));
        let mut res = 0;
        for (i, &count) in freq.iter().enumerate() {
            let presses = (i / 8) + 1;
            res += presses * count;
        }
        res as i32
    }
}