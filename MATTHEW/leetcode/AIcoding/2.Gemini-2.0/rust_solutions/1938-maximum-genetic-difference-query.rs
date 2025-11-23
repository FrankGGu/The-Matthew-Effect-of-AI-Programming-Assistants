use std::collections::HashMap;

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

struct Solution {}

impl Solution {
    pub fn max_genetic_difference(parents: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = parents.len();
        let mut adj: Vec<Vec<usize>> = vec![Vec::new(); n];
        let mut root = None;

        for i in 0..n {
            if parents[i] == -1 {
                root = Some(i);
            } else {
                adj[parents[i] as usize].push(i);
            }
        }

        let mut query_map: HashMap<usize, Vec<(usize, usize)>> = HashMap::new();
        for (i, query) in queries.iter().enumerate() {
            query_map.entry(query[0] as usize).or_insert(Vec::new()).push((query[1] as usize, i));
        }

        let mut root_node = Box::new(TrieNode::new());
        let mut ans = vec![0; queries.len()];

        fn insert(root: &mut Box<TrieNode>, num: i32) {
            let mut curr = root;
            for i in (0..17).rev() {
                let bit = ((num >> i) & 1) as usize;
                if curr.children[bit].is_none() {
                    curr.children[bit] = Some(Box::new(TrieNode::new()));
                }
                curr = curr.children[bit].as_mut().unwrap();
            }
        }

        fn find_max(root: &Box<TrieNode>, num: i32) -> i32 {
            let mut curr = root;
            let mut res = 0;
            for i in (0..17).rev() {
                let bit = ((num >> i) & 1) as usize;
                let opposite_bit = 1 - bit;

                if curr.children[opposite_bit].is_some() {
                    res |= (1 << i);
                    curr = curr.children[opposite_bit].as_ref().unwrap();
                } else {
                    curr = curr.children[bit].as_ref().unwrap();
                }
            }
            res
        }

        fn remove(root: &mut Box<TrieNode>, num: i32) {
            let mut curr = root;
            for i in (0..17).rev() {
                let bit = ((num >> i) & 1) as usize;
                curr = curr.children[bit].as_mut().unwrap();
            }
        }

        fn dfs(
            node: usize,
            adj: &Vec<Vec<usize>>,
            query_map: &HashMap<usize, Vec<(usize, usize)>>,
            root_node: &mut Box<TrieNode>,
            ans: &mut Vec<i32>,
        ) {
            insert(root_node, node as i32);

            if let Some(queries) = query_map.get(&node) {
                for &(xor_val, idx) in queries {
                    ans[idx] = find_max(root_node, xor_val as i32);
                }
            }

            for &child in &adj[node] {
                dfs(child, adj, query_map, root_node, ans);
            }

            remove(root_node, node as i32);
        }

        if let Some(r) = root {
            dfs(r, &adj, &query_map, &mut root_node, &mut ans);
        }

        ans
    }
}