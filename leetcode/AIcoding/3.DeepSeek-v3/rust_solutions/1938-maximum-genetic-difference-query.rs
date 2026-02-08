use std::collections::HashMap;

struct TrieNode {
    children: [Option<Box<TrieNode>>; 2],
    count: i32,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: [None, None],
            count: 0,
        }
    }
}

struct Trie {
    root: TrieNode,
}

impl Trie {
    fn new() -> Self {
        Trie {
            root: TrieNode::new(),
        }
    }

    fn insert(&mut self, num: i32) {
        let mut node = &mut self.root;
        for i in (0..=17).rev() {
            let bit = ((num >> i) & 1) as usize;
            if node.children[bit].is_none() {
                node.children[bit] = Some(Box::new(TrieNode::new()));
            }
            node = node.children[bit].as_mut().unwrap();
            node.count += 1;
        }
    }

    fn remove(&mut self, num: i32) {
        let mut node = &mut self.root;
        for i in (0..=17).rev() {
            let bit = ((num >> i) & 1) as usize;
            let next = node.children[bit].as_mut().unwrap();
            next.count -= 1;
            if next.count == 0 {
                node.children[bit] = None;
                return;
            }
            node = next;
        }
    }

    fn query(&self, num: i32) -> i32 {
        let mut res = 0;
        let mut node = &self.root;
        for i in (0..=17).rev() {
            let bit = ((num >> i) & 1) as usize;
            let desired_bit = 1 - bit;
            if let Some(child) = &node.children[desired_bit] {
                res |= 1 << i;
                node = child;
            } else if let Some(child) = &node.children[bit] {
                node = child;
            } else {
                break;
            }
        }
        res
    }
}

pub fn max_genetic_difference(parents: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
    let n = parents.len();
    let mut tree = vec![vec![]; n];
    let mut root = 0;
    for (i, &p) in parents.iter().enumerate() {
        if p == -1 {
            root = i;
        } else {
            tree[p as usize].push(i);
        }
    }

    let mut query_map = HashMap::new();
    for (idx, q) in queries.iter().enumerate() {
        query_map.entry(q[0] as usize).or_insert(vec![]).push((q[1], idx));
    }

    let mut res = vec![0; queries.len()];
    let mut trie = Trie::new();
    let mut stack = vec![(root, false)];

    while let Some((node, processed)) = stack.pop() {
        if processed {
            trie.remove(node as i32);
        } else {
            stack.push((node, true));
            trie.insert(node as i32);
            if let Some(queries) = query_map.get(&node) {
                for &(val, idx) in queries {
                    res[idx] = trie.query(val);
                }
            }
            for &child in &tree[node] {
                stack.push((child, false));
            }
        }
    }

    res
}