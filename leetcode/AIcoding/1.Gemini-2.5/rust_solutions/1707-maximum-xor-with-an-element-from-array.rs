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
        let mut curr = &mut self.root;
        for i in (0..30).rev() {
            let bit = ((num >> i) & 1) as usize;
            if curr.children[bit].is_none() {
                curr.children[bit] = Some(Box::new(TrieNode::new()));
            }
            curr = curr.children[bit].as_mut().unwrap();
        }
    }

    fn find_max_xor(&self, num: i32) -> i32 {
        let mut curr = &self.root;
        let mut max_xor = 0;
        for i in (0..30).rev() {
            let bit = ((num >> i) & 1) as usize;
            let opposite_bit = 1 - bit;

            if let Some(child_node) = curr.children[opposite_bit].as_ref() {
                max_xor |= 1 << i;
                curr = child_node;
            } else {
                curr = curr.children[bit].as_ref().unwrap();
            }
        }
        max_xor
    }

    fn is_empty(&self) -> bool {
        self.root.children[0].is_none() && self.root.children[1].is_none()
    }
}

impl Solution {
    pub fn maximize_xor(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut nums = nums;
        nums.sort_unstable();

        let mut queries_with_idx: Vec<(i32, i32, usize)> = queries
            .into_iter()
            .enumerate()
            .map(|(i, q)| (q[0], q[1], i))
            .collect();
        queries_with_idx.sort_unstable_by_key(|q| q.1);

        let mut results = vec![-1; queries_with_idx.len()];
        let mut trie = Trie::new();
        let mut num_idx = 0;

        for (xi, mi, original_idx) in queries_with_idx {
            while num_idx < nums.len() && nums[num_idx] <= mi {
                trie.insert(nums[num_idx]);
                num_idx += 1;
            }

            if !trie.is_empty() {
                results[original_idx] = trie.find_max_xor(xi);
            }
        }

        results
    }
}