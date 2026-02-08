use std::collections::{HashMap, HashSet};

struct DSU {
    parent: Vec<usize>,
    size: Vec<usize>,
    num_components: usize,
    max_component_size: usize,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
            size: vec![1; n],
            num_components: n,
            max_component_size: if n > 0 { 1 } else { 0 },
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            let root = self.find(self.parent[i]);
            self.parent[i] = root;
            root
        }
    }

    fn union(&mut self, i: usize, j: usize) -> bool {
        let root_i = self.find(i);
        let root_j = self.find(j);

        if root_i != root_j {
            if self.size[root_i] < self.size[root_j] {
                self.parent[root_i] = root_j;
                self.size[root_j] += self.size[root_i];
                self.max_component_size = self.max_component_size.max(self.size[root_j]);
            } else {
                self.parent[root_j] = root_i;
                self.size[root_i] += self.size[root_j];
                self.max_component_size = self.max_component_size.max(self.size[root_i]);
            }
            self.num_components -= 1;
            true
        } else {
            false
        }
    }
}

impl Solution {
    pub fn groups_of_strings(words: Vec<String>) -> Vec<i32> {
        let mut mask_to_idx: HashMap<i32, usize> = HashMap::new();
        let mut masks_vec: Vec<i32> = Vec::new();

        for word in words {
            let mut mask = 0;
            for c in word.chars() {
                mask |= 1 << ((c as u8) - b'a');
            }
            if !mask_to_idx.contains_key(&mask) {
                mask_to_idx.insert(mask, masks_vec.len());
                masks_vec.push(mask);
            }
        }

        let mut dsu = DSU::new(masks_vec.len());

        for (mask, &idx) in mask_to_idx.iter() {
            // Check for add/delete connections
            // A neighbor mask that differs by exactly one bit (either added or removed)
            for i in 0..26 {
                let neighbor_mask = mask ^ (1 << i);
                if mask_to_idx.contains_key(&neighbor_mask) {
                    dsu.union(idx, mask_to_idx[&neighbor_mask]);
                }
            }

            // Check for replace connections
            // A replace operation means changing one character 'c1' to 'c2'.
            // This implies 'c1' is in the current mask and 'c2' is not.
            // The new mask will be (mask - 'c1') + 'c2'.
            for i in 0..26 { // character to remove (c1)
                if (mask & (1 << i)) != 0 { // if char 'i' is present in the mask
                    let mask_without_i = mask ^ (1 << i);
                    for j in 0..26 { // character to add (c2)
                        if (mask & (1 << j)) == 0 { // if char 'j' is NOT present in the mask
                            let mask_with_j = mask_without_i | (1 << j);
                            if mask_to_idx.contains_key(&mask_with_j) {
                                dsu.union(idx, mask_to_idx[&mask_with_j]);
                            }
                        }
                    }
                }
            }
        }

        vec![dsu.num_components as i32, dsu.max_component_size as i32]
    }
}