use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn group_strings(words: Vec<String>) -> Vec<i32> {
        let mut parent: HashMap<i32, i32> = HashMap::new();
        let mut size: HashMap<i32, i32> = HashMap::new();

        fn find(u: i32, parent: &mut HashMap<i32, i32>) -> i32 {
            if *parent.entry(u).or_insert(u) != u {
                parent.insert(u, find(parent[&u], parent));
            }
            parent[&u]
        }

        fn union(u: i32, v: i32, parent: &mut HashMap<i32, i32>, size: &mut HashMap<i32, i32>) {
            let root_u = find(u, parent);
            let root_v = find(v, parent);
            if root_u != root_v {
                let size_u = *size.entry(root_u).or_insert(1);
                let size_v = *size.entry(root_v).or_insert(1);
                if size_u < size_v {
                    parent.insert(root_u, root_v);
                    size.insert(root_v, size_u + size_v);
                } else {
                    parent.insert(root_v, root_u);
                    size.insert(root_u, size_u + size_v);
                }
            }
        }

        let mut mask_count = HashMap::new();
        for word in words {
            let mut mask = 0;
            for c in word.chars() {
                mask |= 1 << (c as u8 - b'a');
            }
            *mask_count.entry(mask).or_insert(0) += 1;
        }

        let masks: Vec<i32> = mask_count.keys().cloned().collect();
        for &mask in &masks {
            find(mask, &mut parent);
            for i in 0..26 {
                let new_mask = mask ^ (1 << i);
                if mask_count.contains_key(&new_mask) {
                    union(mask, new_mask, &mut parent, &mut size);
                }
                if (mask & (1 << i)) != 0 {
                    for j in 0..26 {
                        if (mask & (1 << j)) == 0 {
                            let new_mask = mask ^ (1 << i) | (1 << j);
                            if mask_count.contains_key(&new_mask) {
                                union(mask, new_mask, &mut parent, &mut size);
                            }
                        }
                    }
                }
            }
        }

        let mut root_sizes = HashMap::new();
        for &mask in &masks {
            let root = find(mask, &mut parent);
            *root_sizes.entry(root).or_insert(0) += mask_count[&mask];
        }

        let max_group_size = *root_sizes.values().max().unwrap_or(&0);
        let total_groups = root_sizes.len() as i32;

        vec![total_groups, max_group_size]
    }
}