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
    max_bit: i32,
}

impl Trie {
    fn new(max_bit: i32) -> Self {
        Trie {
            root: TrieNode::new(),
            max_bit,
        }
    }

    fn insert(&mut self, num: i32) {
        let mut node = &mut self.root;
        for i in (0..=self.max_bit).rev() {
            let bit = ((num >> i) & 1) as usize;
            if node.children[bit].is_none() {
                node.children[bit] = Some(Box::new(TrieNode::new()));
            }
            node = node.children[bit].as_mut().unwrap();
            node.count += 1;
        }
    }

    fn count_less(&self, num: i32, limit: i32) -> i32 {
        let mut node = &self.root;
        let mut res = 0;
        for i in (0..=self.max_bit).rev() {
            if node.is_none() {
                break;
            }
            let num_bit = (num >> i) & 1;
            let limit_bit = (limit >> i) & 1;
            if limit_bit == 1 {
                if let Some(child) = &node.children[num_bit as usize] {
                    res += child.count;
                }
                if let Some(child) = &node.children[1 - num_bit as usize] {
                    node = child;
                } else {
                    break;
                }
            } else {
                if let Some(child) = &node.children[num_bit as usize] {
                    node = child;
                } else {
                    break;
                }
            }
        }
        res
    }
}

impl Solution {
    pub fn count_pairs(nums: Vec<i32>, low: i32, high: i32) -> i32 {
        let max_bit = 14;
        let mut trie = Trie::new(max_bit);
        let mut res = 0;
        for num in nums {
            res += trie.count_less(num, high + 1) - trie.count_less(num, low);
            trie.insert(num);
        }
        res
    }
}