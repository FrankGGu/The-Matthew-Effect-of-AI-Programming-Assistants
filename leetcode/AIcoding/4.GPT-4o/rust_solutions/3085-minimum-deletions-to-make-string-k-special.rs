impl Solution {
    pub fn minimum_deletions(s: String, k: i32) -> i32 {
        let mut count = vec![0; 26];
        for ch in s.chars() {
            count[(ch as u8 - b'a') as usize] += 1;
        }

        count.sort_unstable_by(|a, b| b.cmp(a));

        let mut deletions = 0;
        for i in 0..26 {
            if count[i] == 0 {
                break;
            }
            if i < k as usize {
                deletions += count[i] - 1;
            } else {
                deletions += count[i];
            }
        }

        deletions
    }
}