use std::collections::HashSet;

impl Solution {
    pub fn distinct_names(ideas: Vec<String>) -> i64 {
        let mut groups: Vec<HashSet<&str>> = vec![HashSet::new(); 26];
        for idea in &ideas {
            let bytes = idea.as_bytes();
            let first_char = bytes[0] as usize - 'a' as usize;
            let suffix = &idea[1..];
            groups[first_char].insert(suffix);
        }

        let mut res = 0;
        for i in 0..26 {
            for j in i + 1..26 {
                let common = groups[i].intersection(&groups[j]).count();
                res += 2 * ((groups[i].len() - common) * (groups[j].len() - common));
            }
        }
        res as i64
    }
}