impl Solution {
    pub fn make_equal(words: Vec<String>) -> bool {
        let mut counts = [0; 26];
        let n = words.len();

        for word in words {
            for c in word.chars() {
                counts[(c as u8 - b'a') as usize] += 1;
            }
        }

        counts.iter().all(|&count| count % n == 0)
    }
}