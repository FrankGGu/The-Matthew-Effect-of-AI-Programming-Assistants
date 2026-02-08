impl Solution {
    pub fn find_replace_string(s: String, indices: Vec<i32>, sources: Vec<String>, targets: Vec<String>) -> String {
        let mut result = s.clone();
        let mut replacements = vec![];

        for (i, &index) in indices.iter().enumerate() {
            let start = index as usize;
            let source = &sources[i];
            if s[start..start + source.len()] == *source {
                replacements.push((start, targets[i].clone()));
            }
        }

        replacements.sort_by(|a, b| b.0.cmp(&a.0));

        for (start, target) in replacements {
            result.replace_range(start..start + target.len(), &target);
        }

        result
    }
}