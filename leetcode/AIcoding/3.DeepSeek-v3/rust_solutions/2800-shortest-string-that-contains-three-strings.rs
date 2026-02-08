impl Solution {
    fn merge(a: &str, b: &str) -> String {
        if a.contains(b) {
            return a.to_string();
        }
        if b.contains(a) {
            return b.to_string();
        }
        let max_overlap = (0..=std::cmp::min(a.len(), b.len())).rev().find(|&len| {
            a.ends_with(&b[..len]) || b.ends_with(&a[..len])
        }).unwrap_or(0);
        if a.len() >= b.len() {
            format!("{}{}", a, &b[max_overlap..])
        } else {
            format!("{}{}", b, &a[max_overlap..])
        }
    }

    fn shortest_superstring_util(strings: &mut Vec<String>) -> String {
        while strings.len() > 1 {
            let mut max_overlap = -1;
            let mut x = 0;
            let mut y = 0;
            let mut best_merge = String::new();
            for i in 0..strings.len() {
                for j in i + 1..strings.len() {
                    let merged = Self::merge(&strings[i], &strings[j]);
                    let overlap = strings[i].len() + strings[j].len() - merged.len();
                    if overlap > max_overlap {
                        max_overlap = overlap as i32;
                        best_merge = merged;
                        x = i;
                        y = j;
                    }
                }
            }
            let last = strings.pop().unwrap();
            if y == strings.len() {
                strings[x] = best_merge;
            } else {
                strings[x] = last;
                strings[y] = best_merge;
            }
        }
        strings[0].clone()
    }

    pub fn shortest_superstring(words: Vec<String>) -> String {
        let mut words = words;
        Self::shortest_superstring_util(&mut words)
    }
}