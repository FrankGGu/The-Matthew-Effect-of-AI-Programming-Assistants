impl Solution {

use std::collections::HashMap;

struct MapSum {
    root: Node,
}

struct Node {
    children: HashMap<char, Node>,
    value: i32,
}

impl MapSum {
    fn new() -> Self {
        MapSum {
            root: Node {
                children: HashMap::new(),
                value: 0,
            },
        }
    }

    fn insert(&mut self, key: String, val: i32) {
        let mut node = &mut self.root;
        for c in key.chars() {
            node = node.children.entry(c).or_insert(Node {
                children: HashMap::new(),
                value: 0,
            });
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

    fn dfs(&self, node: &Node) -> i32 {
        let mut total = node.value;
        for child in node.children.values() {
            total += self.dfs(child);
        }
        total
    }
}
}