use std::collections::HashMap;

impl Solution {
    pub fn min_deletions(s: String, k: i32) -> i32 {
        let mut freq: HashMap<char, i32> = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut counts: Vec<i32> = freq.values().cloned().collect();
        counts.sort_by(|a, b| b.cmp(a));

        let mut ans = 0;
        let mut distinct = counts.len() as i32;
        for i in 0..counts.len() {
            if distinct <= k {
                break;
            }

            while counts[i] > 0 && distinct > k {
                counts[i] -= 1;
                ans += 1;
                if counts[i] == 0 {
                    distinct -= 1;
                } else {
                    let mut seen = false;
                    for j in 0..i {
                        if counts[j] == counts[i] {
                            seen = true;
                            break;
                        }
                    }
                    if seen {
                        distinct -=1;
                    }
                }

            }
        }

        let mut counts_map : HashMap<i32,i32> = HashMap::new();
        for i in 0..counts.len(){
            if counts[i] > 0 {
                *counts_map.entry(counts[i]).or_insert(0) += 1;
            }
        }

        let mut deletions = 0;
        let mut available = k;
        for i in 0..counts.len(){
            if counts[i] > 0 {
                 while counts[i] > 0 && counts_map.get(&counts[i]).unwrap_or(&0) > &1 && available < distinct {
                    counts[i] -= 1;
                    deletions += 1;
                    distinct -=1;
                    *counts_map.entry(counts[i]).or_insert(0) += 1;
                }
            }
        }

        ans
    }
}