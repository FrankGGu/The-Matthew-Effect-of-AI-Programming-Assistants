use std::collections::HashMap;

struct TrieNode {
    children: HashMap<char, TrieNode>,
    value: i32,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: HashMap::new(),
            value: 0,
        }
    }
}

struct MapSum {
    root: TrieNode,
}

impl MapSum {
    fn new() -> Self {
        MapSum {
            root: TrieNode::new(),
        }
    }

    fn insert(&mut self, key: String, val: i32) {
        let mut node = &mut self.root;
        for c in key.chars() {
            node = node.children.entry(c).or_insert_with(TrieNode::new);
        }
        node.value = val;
    }

    fn sum(&self, prefix: String) -> i32 {
        let mut node = &self.root;
        for c in prefix.chars() {
            if let Some(child) = node.children.get(&c) {
                node = child;
            } else {
                return 0;
            }
        }
        self.dfs(node)
    }

    fn dfs(&self, node: &TrieNode) -> i32 {
        let mut sum = node.value;
        for child in node.children.values() {
            sum += self.dfs(child);
        }
        sum
    }
}