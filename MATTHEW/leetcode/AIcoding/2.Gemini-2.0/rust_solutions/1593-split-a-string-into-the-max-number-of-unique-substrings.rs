impl Solution {
    pub fn max_unique_split(s: String) -> i32 {
        let mut max_splits = 0;
        let mut used = std::collections::HashSet::new();

        fn backtrack(s: &str, start: usize, used: &mut std::collections::HashSet<String>, splits: &mut i32, max_splits: &mut i32) {
            if start == s.len() {
                *max_splits = (*max_splits).max(*splits);
                return;
            }

            for i in start+1..=s.len() {
                let sub = &s[start..i];
                if !used.contains(sub) {
                    used.insert(sub.to_string());
                    *splits += 1;
                    backtrack(s, i, used, splits, max_splits);
                    *splits -= 1;
                    used.remove(sub);
                }
            }
        }

        let mut splits = 0;
        backtrack(&s, 0, &mut used, &mut splits, &mut max_splits);

        max_splits
    }
}