impl Solution {
    pub fn maximum_deletions(s: String) -> i32 {
        let mut count = vec![0; 26];
        for ch in s.chars() {
            count[(ch as usize) - ('a' as usize)] += 1;
        }
        count.sort_unstable_by(|a, b| b.cmp(a));
        let mut max_deletions = 0;
        let mut prev = 0;

        for &c in &count {
            if c == 0 {
                break;
            }
            max_deletions += (c - prev).max(0);
            prev = (c - 1).max(0);
        }

        max_deletions
    }
}