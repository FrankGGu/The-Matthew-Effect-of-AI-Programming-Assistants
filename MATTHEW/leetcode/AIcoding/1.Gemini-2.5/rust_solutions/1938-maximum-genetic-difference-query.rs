struct TrieNode {
    children: [Option<Box<TrieNode>>; 2],
    count: usize,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: [None, None],
            count: 0,
        }
    }

    fn insert(&mut self, num: i32, bit_idx: i32) {
        self.count += 1;
        if bit_idx < 0 {
            return;
        }

        let bit = ((num >> bit_idx) & 1) as usize;
        if self.children[bit].is_none() {
            self.children[bit] = Some(Box::new(TrieNode::new()));
        }
        self.children[bit].as_mut().unwrap().insert(num, bit_idx - 1);
    }

    fn remove(&mut self, num: i32, bit_idx: i32) {
        self.count -= 1;
        if bit_idx < 0 {
            return;
        }

        let bit = ((num >> bit_idx) & 1) as usize;
        if let Some(child_node) = self.children[bit].as_mut() {
            child_node.remove(num, bit_idx - 1);
            if child_node.count == 0 {
                self.children[bit] = None;
            }
        }
    }

    fn query_max_xor(&self, num: i32, bit_idx: i32) -> i32 {
        if bit_idx < 0 {
            return 0;
        }

        let desired_bit = ((num >> bit_idx) & 1) as usize;
        let opposite_bit = 1 - desired_bit;

        if let Some(child_node) = &self.children[opposite_bit] {
            return (1 << bit_idx) + child_node.query_max_xor(num, bit_idx - 1);
        } else if let Some(child_node) = &self.children[desired_bit] {
            return child_node.query_max_xor(num, bit_idx - 1);
        } else {
            0
        }
    }
}

const MAX_BITS: i32 = 29; // Since nums[i] and val can be up to 10^9, which requires 30 bits (0 to 29).

struct Solution;

impl Solution {
    pub fn max_genetic_difference(parents: Vec<i32>, nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = parents.len();
        let q_len = queries.len();

        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        let mut root = 0;
        for i in 0..n {
            if parents[i] == -1 {
                root = i;
            } else {
                adj[parents[i] as usize].push(i);
            }
        }

        let mut queries_at_node: Vec<Vec<(i32, usize)>> = vec![vec![]; n];
        for (i, query) in queries.into_iter().enumerate() {
            let node_u = query[0] as usize;
            let val = query[1];
            queries_at_node[node_u].push((val, i));
        }

        let mut results: Vec<i32> = vec![0; q_len];
        let mut trie = TrieNode::new();

        Self::dfs(root, &adj, &nums, &queries_at_node, &mut trie, &mut results);

        results
    }

    fn dfs(
        u: usize,
        adj: &Vec<Vec<usize>>,
        nums: &Vec<i32>,
        queries_at_node: &Vec<Vec<(i32, usize)>>,
        trie: &mut TrieNode,
        results: &mut Vec<i32>,
    ) {
        trie.insert(nums[u], MAX_BITS);

        for &(val, query_idx) in queries_at_node[u].iter() {
            results[query_idx] = trie.query_max_xor(val, MAX_BITS);
        }

        for &v in adj[u].iter() {
            Self::dfs(v, adj, nums, queries_at_node, trie, results);
        }

        trie.remove(nums[u], MAX_BITS);
    }
}