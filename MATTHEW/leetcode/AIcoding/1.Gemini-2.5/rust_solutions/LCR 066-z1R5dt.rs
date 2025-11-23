use std::collections::HashMap;

#[derive(Default)]
struct TrieNode {
    children: [Option<Box<TrieNode>>; 26],
    sum_val: i32,
}

struct MapSum {
    root: TrieNode,
    key_values: HashMap<String, i32>,
}

impl MapSum {
    fn new() -> Self {
        MapSum {
            root: TrieNode::default(),
            key_values: HashMap::new(),
        }
    }

    fn insert(&mut self, key: String, val: i32) {
        let old_val = self.key_values.get(&key).cloned().unwrap_or(0);
        let delta = val - old_val;

        self.key_values.insert(key.clone(), val);

        let mut curr = &mut self.root;
        for c in key.chars() {
            let idx = (c as u8 - b'a') as usize;
            if curr.children[idx].is_none() {
                curr.children[idx] = Some(Box::new(TrieNode::default()));
            }
            curr = curr.children[idx].as_mut().unwrap();
            curr.sum_val += delta;
        }
    }

    fn sum(&self, prefix: String) -> i32 {
        let mut curr = &self.root;
        for c in prefix.chars() {
            let idx = (c as u8 - b'a') as usize;
            if curr.children[idx].is_none() {
                return 0;
            }
            curr = curr.children[idx].as_ref().unwrap();
        }
        curr.sum_val
    }
}