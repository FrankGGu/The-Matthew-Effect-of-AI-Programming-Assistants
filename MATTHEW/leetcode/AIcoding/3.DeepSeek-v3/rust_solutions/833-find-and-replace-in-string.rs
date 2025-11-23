impl Solution {
    pub fn find_replace_string(s: String, indices: Vec<i32>, sources: Vec<String>, targets: Vec<String>) -> String {
        let mut operations: Vec<(usize, usize, String)> = Vec::new();
        for i in 0..indices.len() {
            let idx = indices[i] as usize;
            let source = &sources[i];
            if s[idx..].starts_with(source) {
                operations.push((idx, idx + source.len(), targets[i].clone()));
            }
        }
        operations.sort_by_key(|&(start, _, _)| std::cmp::Reverse(start));
        let mut result = s.chars().collect::<Vec<char>>();
        for (start, end, target) in operations {
            let target_chars: Vec<char> = target.chars().collect();
            result.splice(start..end, target_chars);
        }
        result.into_iter().collect()
    }
}