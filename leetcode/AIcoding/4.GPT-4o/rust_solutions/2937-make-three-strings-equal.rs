impl Solution {
    pub fn make_equal(words: Vec<String>) -> bool {
        let n = words.len();
        let mut count = vec![0; 26];

        for word in words {
            for ch in word.chars() {
                count[(ch as usize - 'a' as usize)] += 1;
            }
        }

        for &c in &count {
            if c % n != 0 {
                return false;
            }
        }

        true
    }
}