use std::collections::HashMap;

impl Solution {
    pub fn count_pairs(nums: Vec<i32>, low: i32, high: i32) -> i32 {
        fn count(nums: &Vec<i32>, k: i32) -> i32 {
            let mut trie = Trie::new();
            let mut count = 0;
            for &num in nums {
                count += trie.query(num, k);
                trie.insert(num);
            }
            count
        }

        count(&nums, high) - count(&nums, low - 1)
    }
}

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
        Trie { root: TrieNode::new() }
    }

    fn insert(&mut self, num: i32) {
        let mut node = &mut self.root;
        for i in (0..15).rev() {
            let bit = (num >> i) & 1;
            if node.children[bit as usize].is_none() {
                node.children[bit as usize] = Some(Box::new(TrieNode::new()));
            }
            node = node.children[bit as usize].as_mut().unwrap();
            node.count += 1;
        }
    }

    fn query(&self, num: i32, k: i32) -> i32 {
        let mut node = &self.root;
        let mut count = 0;
        for i in (0..15).rev() {
            if node.children[0].is_none() && node.children[1].is_none(){
                break;
            }
            let num_bit = (num >> i) & 1;
            let k_bit = (k >> i) & 1;

            if k_bit == 0 {
                if let Some(child) = &node.children[num_bit as usize] {
                    node = child.as_ref();
                } else {
                    break;
                }
            } else {
                if let Some(child) = &node.children[1 - num_bit as usize] {
                    count += child.count;
                }
                if let Some(child) = &node.children[num_bit as usize] {
                    node = child.as_ref();
                } else {
                    break;
                }
            }
        }
        count
    }
}