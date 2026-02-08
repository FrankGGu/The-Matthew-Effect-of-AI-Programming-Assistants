struct Solution;

const MAX_BITS: usize = 30; // Max value 10^9 < 2^30

#[derive(Clone, Copy)]
struct Node {
    children: [Option<usize>; 2],
    max_idx: isize, // Maximum index of a prefix_xor value passing through this node
}

impl Node {
    fn new() -> Self {
        Node {
            children: [None, None],
            max_idx: -1, // -1 indicates no valid index has passed through this node
        }
    }
}

impl Solution {
    fn build_trie_recursive(
        nodes: &mut Vec<Node>,
        prev_node_idx: usize,
        val: i32,
        idx: usize,
        bit_pos: isize,
    ) -> usize {
        let new_node_idx = nodes.len();
        nodes.push(Node::new());

        if bit_pos < 0 {
            // Leaf node
            nodes[new_node_idx].max_idx = idx as isize;
            return new_node_idx;
        }

        let bit = ((val >> bit_pos) & 1) as usize;
        let other_bit = 1 - bit;

        let prev_child_bit_idx = nodes[prev_node_idx].children[bit].unwrap_or(0);

        // Recursively build the 'bit' child
        let new_child_bit_idx =
            Self::build_trie_recursive(nodes, prev_child_bit_idx, val, idx, bit_pos - 1);
        nodes[new_node_idx].children[bit] = Some(new_child_bit_idx);

        // For the 'other_bit' child, just copy the pointer from the previous Trie
        nodes[new_node_idx].children[other_bit] = nodes[prev_node_idx].children[other_bit];

        // Calculate max_idx for the current new node
        let mut current_max_idx = nodes[new_child_bit_idx].max_idx;
        if let Some(other_child_idx) = nodes[new_node_idx].children[other_bit] {
            current_max_idx = current_max_idx.max(nodes[other_child_idx].max_idx);
        }
        nodes[new_node_idx].max_idx = current_max_idx;

        new_node_idx
    }

    fn query_max_xor(
        nodes: &Vec<Node>,
        query_val: i32,
        trie_root_idx: usize,
        min_idx_threshold: isize,
    ) -> i32 {
        let mut curr_node_idx = trie_root_idx;

        // If the current root (or subtree) does not contain any element
        // with an index >= min_idx_threshold, return 0.
        if nodes[curr_node_idx].max_idx < min_idx_threshold {
            return 0;
        }

        let mut max_xor_val = 0;
        for b in (0..MAX_BITS).rev() {
            let bit = ((query_val >> b) & 1) as usize;
            let desired_bit = 1 - bit;

            let child_desired_option = nodes[curr_node_idx].children[desired_bit];
            let child_actual_option = nodes[curr_node_idx].children[bit];

            let mut next_node_found = false;

            if let Some(idx) = child_desired_option {
                if nodes[idx].max_idx >= min_idx_threshold {
                    max_xor_val |= 1 << b;
                    curr_node_idx = idx;
                    next_node_found = true;
                }
            }

            if !next_node_found {
                if let Some(idx) = child_actual_option {
                    if nodes[idx].max_idx >= min_idx_threshold {
                        curr_node_idx = idx;
                        next_node_found = true;
                    }
                }
            }

            if !next_node_found {
                return max_xor_val;
            }
        }
        max_xor_val
    }

    pub fn max_xor_score_subarray_queries(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = nums.len();
        let mut prefix_xor = Vec::with_capacity(n + 1);
        prefix_xor.push(0); // P[0] = 0
        let mut current_xor = 0;
        for &num in &nums {
            current_xor ^= num;
            prefix_xor.push(current_xor);
        }

        let mut nodes: Vec<Node> = Vec::new();
        nodes.push(Node::new()); // Dummy node 0, max_idx = -1

        let mut roots: Vec<usize> = Vec::with_capacity(n + 2);
        roots.push(0); // roots[0] points to dummy node 0 (empty Trie)

        // roots[k+1] will be the root of the Trie containing P[0]...P[k]
        for k in 0..=n {
            let new_root_idx = Self::build_trie_recursive(
                &mut nodes,
                roots[k], // previous root (roots[k] contains P[0]...P[k-1])
                prefix_xor[k],
                k, // index of P[k]
                (MAX_BITS - 1) as isize,
            );
            roots.push(new_root_idx);
        }

        let mut results = Vec::with_capacity(queries.len());
        for query in queries {
            let left = query[0] as usize;
            let right = query[1] as usize;
            let mut max_overall_xor = 0;

            // We need max(P[k] ^ P[m]) for left <= m < k <= right+1
            // k ranges from left+1 to right+1
            for k in (left + 1)..=(right + 1) {
                let current_xor_val = prefix_xor[k];
                // query_trie_root = roots[k] contains P[0]...P[k-1]
                let query_trie_root = roots[k];
                let max_xor_for_k =
                    Self::query_max_xor(&nodes, current_xor_val, query_trie_root, left as isize);
                max_overall_xor = max_overall_xor.max(max_xor_for_k);
            }
            results.push(max_overall_xor);
        }

        results
    }
}