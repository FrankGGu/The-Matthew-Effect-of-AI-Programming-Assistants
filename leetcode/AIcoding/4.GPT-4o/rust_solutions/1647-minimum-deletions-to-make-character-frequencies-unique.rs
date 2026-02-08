impl Solution {
    pub fn min_deletions(s: String) -> i32 {
        let mut freq = vec![0; 26];
        for c in s.chars() {
            freq[(c as usize - 'a' as usize)] += 1;
        }
        freq.sort_unstable();

        let mut deletions = 0;
        let mut max_freq = 0;
        for &f in freq.iter().rev() {
            if f > max_freq {
                max_freq = f;
            } else if f > 0 {
                deletions += f - max_freq + 1;
                max_freq = max_freq.saturating_sub(1);
            }
        }
        deletions
    }
}