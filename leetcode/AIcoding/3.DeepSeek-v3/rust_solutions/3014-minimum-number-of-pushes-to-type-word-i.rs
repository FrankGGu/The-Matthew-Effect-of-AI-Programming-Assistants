impl Solution {
    pub fn minimum_pushes(word: String) -> i32 {
        let mut counts = [0; 26];
        for c in word.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }
        counts.sort_unstable_by(|a, b| b.cmp(a));
        let mut pushes = 0;
        for (i, &count) in counts.iter().enumerate() {
            pushes += count * ((i / 8) + 1);
        }
        pushes
    }
}