impl Solution {
    pub fn find_replace_string(s: String, indices: Vec<i32>, sources: Vec<String>, targets: Vec<String>) -> String {
        let mut operations: Vec<(usize, &str, &str)> = Vec::new();
        for k in 0..indices.len() {
            operations.push((indices[k] as usize, &sources[k], &targets[k]));
        }

        operations.sort_unstable_by_key(|op| op.0);

        let mut result = String::with_capacity(s.len() + targets.iter().map(|t| t.len()).sum::<usize>());
        let mut s_ptr = 0;

        for (idx, src, tgt) in operations {
            result.push_str(&s[s_ptr..idx]);

            let src_len = src.len();
            let is_match = s.len() >= idx + src_len && s.get(idx..idx + src_len).map_or(false, |sub| sub == src);

            if is_match {
                result.push_str(tgt);
                s_ptr = idx + src_len;
            } else {
                // If not a match, the original characters are preserved.
                // `s_ptr` remains `idx`, so the characters `s[idx..]` will be
                // appended in the next `result.push_str(&s[s_ptr..next_idx])`
                // or the final `result.push_str(&s[s_ptr..])`.
                // No action needed for `s_ptr` in this `else` branch.
            }
        }

        result.push_str(&s[s_ptr..]);

        result
    }
}