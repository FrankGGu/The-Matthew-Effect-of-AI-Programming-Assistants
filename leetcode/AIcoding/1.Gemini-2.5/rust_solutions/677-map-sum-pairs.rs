use std::collections::HashMap;

struct TrieNode {
    children: HashMap<char, Box<TrieNode>>,
    prefix_sum: i32,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: HashMap::new(),
            prefix_sum: 0,
        }
    }
}

struct MapSum {
    root: TrieNode,
    key_values: HashMap<String, i32>,
}

impl MapSum {
    fn new() -> Self {
        MapSum {
            root: TrieNode::new(),
            key_values: HashMap::new(),
        }
    }

    fn insert(&mut self, key: String, val: i32) {
        let old_val = *self.key_values.get(&key).unwrap_or(&0);
        self.key_values.insert(key.clone(), val);
        let diff = val - old_val;

        let mut current_node = &mut self.root;
        for c in key.chars() {
            current_node = current_node.children.entry(c).or_insert_with(|| Box::new(TrieNode::new()));
            current_node.prefix_sum += diff;
        }
    }

    fn sum(&self, prefix: String) -> i32 {
        let mut current_node = &self.root;
        for c in prefix.chars() {
            if let Some(node) = current_node.children.get(&c) {
                current_node = node;
            } else {
                return 0;
            }
        }
        current_node.prefix_sum
    }
}