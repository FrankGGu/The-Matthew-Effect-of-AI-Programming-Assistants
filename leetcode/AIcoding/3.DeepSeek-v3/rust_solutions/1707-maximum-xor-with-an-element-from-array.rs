struct TrieNode {
    children: [Option<Box<TrieNode>>; 2],
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: [None, None],
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
        for i in (0..31).rev() {
            let bit = ((num >> i) & 1) as usize;
            if node.children[bit].is_none() {
                node.children[bit] = Some(Box::new(TrieNode::new()));
            }
            node = node.children[bit].as_mut().unwrap();
        }
    }

    fn find_max_xor(&self, num: i32) -> i32 {
        let mut node = &self.root;
        let mut res = 0;
        for i in (0..31).rev() {
            let bit = ((num >> i) & 1) as usize;
            let toggle_bit = 1 - bit;
            if let Some(child) = &node.children[toggle_bit] {
                res |= 1 << i;
                node = child;
            } else if let Some(child) = &node.children[bit] {
                node = child;
            } else {
                return -1;
            }
        }
        res
    }
}

impl Solution {
    pub fn maximize_xor(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut nums = nums;
        nums.sort_unstable();
        let mut queries_with_index: Vec<(i32, i32, usize)> = queries
            .iter()
            .enumerate()
            .map(|(i, q)| (q[0], q[1], i))
            .collect();
        queries_with_index.sort_unstable_by_key(|&(_, m, _)| m);
        let mut trie = Trie::new();
        let mut res = vec![-1; queries.len()];
        let mut idx = 0;
        for (x, m, original_idx) in queries_with_index {
            while idx < nums.len() && nums[idx] <= m {
                trie.insert(nums[idx]);
                idx += 1;
            }
            if idx > 0 {
                res[original_idx] = trie.find_max_xor(x);
            }
        }
        res
    }
}