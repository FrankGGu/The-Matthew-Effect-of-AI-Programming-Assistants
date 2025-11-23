use std::collections::HashSet;

impl Solution {
    pub fn min_deletions(s: String) -> i32 {
        let mut freq = vec![0; 26];
        for c in s.chars() {
            freq[(c as u8 - b'a') as usize] += 1;
        }
        freq.sort_unstable_by(|a, b| b.cmp(a));
        let mut used = HashSet::new();
        let mut deletions = 0;
        for &count in &freq {
            if count == 0 {
                break;
            }
            let mut current = count;
            while current > 0 && used.contains(¤t) {
                current -= 1;
                deletions += 1;
            }
            if current > 0 {
                used.insert(current);
            }
        }
        deletions
    }
}