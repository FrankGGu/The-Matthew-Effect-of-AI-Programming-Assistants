impl Solution {
    pub fn make_equal(words: Vec<String>) -> bool {
        let n = words.len();
        if n == 1 {
            return true;
        }

        let mut counts = [0; 26];

        for word in words.iter() {
            for c in word.chars() {
                counts[(c as u8 - b'a') as usize] += 1;
            }
        }

        for count in counts.iter() {
            if *count % n != 0 {
                return false;
            }
        }

        true
    }
}