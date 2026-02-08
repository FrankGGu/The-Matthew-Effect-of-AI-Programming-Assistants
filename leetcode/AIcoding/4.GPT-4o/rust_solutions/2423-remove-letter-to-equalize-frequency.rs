impl Solution {
    pub fn equal_frequency(word: String) -> bool {
        let mut freq = [0; 26];
        for c in word.chars() {
            freq[c as usize - 'a' as usize] += 1;
        }

        let mut count = std::collections::HashMap::new();
        for &f in &freq {
            if f > 0 {
                *count.entry(f).or_insert(0) += 1;
            }
        }

        if count.len() == 1 {
            return true;
        }

        if count.len() == 2 {
            let mut keys = count.keys().cloned().collect::<Vec<_>>();
            keys.sort();
            let (a, b) = (keys[0], keys[1]);
            if (a == 1 && count[&a] == 1) || (b == a + 1 && count[&b] == 1) {
                return true;
            }
        }

        false
    }
}