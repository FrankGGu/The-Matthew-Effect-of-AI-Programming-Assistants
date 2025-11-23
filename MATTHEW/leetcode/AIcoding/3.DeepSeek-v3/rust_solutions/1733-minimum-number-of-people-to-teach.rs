use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn minimum_teachings(n: i32, languages: Vec<Vec<i32>>, friendships: Vec<Vec<i32>>) -> i32 {
        let m = languages.len();
        let mut lang_sets = vec![HashSet::new(); m];
        for (i, langs) in languages.iter().enumerate() {
            for &lang in langs {
                lang_sets[i].insert(lang);
            }
        }

        let mut need_teach = vec![false; m];
        for friend in friendships {
            let u = friend[0] as usize - 1;
            let v = friend[1] as usize - 1;
            if lang_sets[u].is_disjoint(&lang_sets[v]) {
                need_teach[u] = true;
                need_teach[v] = true;
            }
        }

        let mut count = HashMap::new();
        let mut total = 0;
        for i in 0..m {
            if need_teach[i] {
                total += 1;
                for &lang in &lang_sets[i] {
                    *count.entry(lang).or_insert(0) += 1;
                }
            }
        }

        if total == 0 {
            return 0;
        }

        let max_known = count.values().max().unwrap_or(&0);
        total - max_known
    }
}