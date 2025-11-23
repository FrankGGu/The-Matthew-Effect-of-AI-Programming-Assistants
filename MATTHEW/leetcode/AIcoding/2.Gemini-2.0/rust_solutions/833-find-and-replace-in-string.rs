impl Solution {
    pub fn find_and_replace_string(s: String, indices: Vec<i32>, sources: Vec<String>, targets: Vec<String>) -> String {
        let mut operations: Vec<(usize, String, String)> = indices
            .iter()
            .zip(sources.iter().zip(targets.iter()))
            .map(|(&i, (source, target))| (i as usize, source.clone(), target.clone()))
            .collect();

        operations.sort_unstable_by_key(|&(i, _, _)| i);

        let mut result = String::new();
        let mut current_index = 0;

        for (index, source, target) in operations {
            if index < current_index {
                continue;
            }

            if s[current_index..].starts_with(&s[index..index + source.len()]) && s[index..index + source.len()] == source {
                result.push_str(&s[current_index..index]);
                result.push_str(&target);
                current_index = index + source.len();
            } else {

            }
        }

        result.push_str(&s[current_index..]);

        result
    }
}