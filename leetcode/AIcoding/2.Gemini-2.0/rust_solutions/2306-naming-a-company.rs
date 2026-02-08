use std::collections::HashSet;

impl Solution {
    pub fn distinct_names(ideas: Vec<String>) -> i64 {
        let mut groups: Vec<HashSet<String>> = vec![HashSet::new(); 26];
        for idea in &ideas {
            let first_char = idea.chars().next().unwrap() as u8 - b'a';
            groups[first_char as usize].insert(idea[1..].to_string());
        }

        let mut count: i64 = 0;
        for i in 0..26 {
            for j in i + 1..26 {
                let intersection_size = groups[i].intersection(&groups[j]).count() as i64;
                count += (groups[i].len() as i64 - intersection_size) * (groups[j].len() as i64 - intersection_size);
            }
        }

        count * 2
    }
}