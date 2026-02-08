use std::collections::HashMap;
use std::cmp::{min, max};

const MAX_VAL: usize = 100_000;

struct Node {
    sum_gcd_pairs: i64,
    // Stores count of numbers in the node's range divisible by 'g'
    // Only non-zero counts are stored to save space.
    divisor_counts: HashMap<i32, i32>,
}

impl Node {
    fn new() -> Self {
        Node {
            sum_gcd_pairs: 0,
            divisor_counts: HashMap::new(),
        }
    }
}

static mut PHI: Vec<i64> = Vec::new();
static mut DIVISORS_CACHE: Vec<Vec<i32>> = Vec::new();

fn precompute_phi_and_divisors() {
    unsafe {
        PHI.resize(MAX_VAL + 1, 0);
        DIVISORS_CACHE.resize(MAX_VAL + 1, Vec::new());

        for i in 0..=MAX_VAL {
            PHI[i] = i as i64;
        }

        for i in 2..=MAX_VAL {
            if PHI[i] == i as i64 { // i is prime
                for j in (i..=MAX_VAL).step_by(i) {
                    PHI[j] -= PHI[j] / (i as i64);
                }
            }
        }

        for i in 1..=MAX_VAL {
            for j in (i..=MAX_VAL).step_by(i) {
                DIVISORS_CACHE[j].push(i as i32);
            }
        }
    }
}

struct SegmentTree {
    tree: Vec<Node>,
    nums: Vec<i32>,
}

impl SegmentTree {
    fn new(nums: Vec<i32>) -> Self {
        let n = nums.len();
        let mut tree = vec![Node::new(); 4 * n];
        let mut seg_tree = SegmentTree { tree, nums };
        seg_tree.build(1, 0, n - 1);
        seg_tree
    }

    fn build(&mut self, node_idx: usize, start: usize, end: usize) {
        if start == end {
            let num = self.nums[start];
            unsafe {
                for &d in DIVISORS_CACHE[num as usize].iter() {
                    self.tree[node_idx].divisor_counts.insert(d, 1);
                }
            }
        } else {
            let mid = start + (end - start) / 2;
            self.build(2 * node_idx, start, mid);
            self.build(2 * node_idx + 1, mid + 1, end);
            self.merge(node_idx, 2 * node_idx, 2 * node_idx + 1);
        }
    }

    fn merge(&mut self, parent_idx: usize, left_idx: usize, right_idx: usize) {
        let left_node = &self.tree[left_idx];
        let right_node = &self.tree[right_idx];

        let mut new_sum_gcd_pairs = left_node.sum_gcd_pairs + right_node.sum_gcd_pairs;
        let mut new_divisor_counts = left_node.divisor_counts.clone();

        unsafe {
            for (&g, &r_count) in right_node.divisor_counts.iter() {
                let l_count = *new_divisor_counts.get(&g).unwrap_or(&0);
                new_sum_gcd_pairs += PHI[g as usize] * (l_count as i64) * (r_count as i64);
                *new_divisor_counts.entry(g).or_insert(0) += r_count;
            }
        }

        self.tree[parent_idx].sum_gcd_pairs = new_sum_gcd_pairs;
        self.tree[parent_idx].divisor_counts = new_divisor_counts;
    }

    fn query(&self, node_idx: usize, start: usize, end: usize, l: usize, r: usize) -> Node {
        if r < start || end < l {
            return Node::new(); // Empty node
        }

        if l <= start && end <= r {
            return self.tree[node_idx].clone(); // Return a copy of the node
        }

        let mid = start + (end - start) / 2;
        let left_res = self.query(2 * node_idx, start, mid, l, r);
        let right_res = self.query(2 * node_idx + 1, mid + 1, end, l, r);

        // Merge results from children
        let mut merged_node = Node::new();
        merged_node.sum_gcd_pairs = left_res.sum_gcd_pairs + right_res.sum_gcd_pairs;
        merged_node.divisor_counts = left_res.divisor_counts;

        unsafe {
            for (&g, &r_count) in right_res.divisor_counts.iter() {
                let l_count = *merged_node.divisor_counts.get(&g).unwrap_or(&0);
                merged_node.sum_gcd_pairs += PHI[g as usize] * (l_count as i64) * (r_count as i64);
                *merged_node.divisor_counts.entry(g).or_insert(0) += r_count;
            }
        }
        merged_node
    }
}

impl Clone for Node {
    fn clone(&self) -> Self {
        Node {
            sum_gcd_pairs: self.sum_gcd_pairs,
            divisor_counts: self.divisor_counts.clone(),
        }
    }
}

impl Solution {
    pub fn get_gcd_sum(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i64> {
        unsafe {
            if PHI.is_empty() { // Ensure precomputation runs only once
                precompute_phi_and_divisors();
            }
        }

        let n = nums.len();
        let segment_tree = SegmentTree::new(nums);

        let mut results = Vec::with_capacity(queries.len());

        for query in queries {
            let l = query[0] as usize;
            let r = query[1] as usize;

            // The query range is 0-indexed [L, R]
            let node_result = segment_tree.query(1, 0, n - 1, l, r);
            results.push(node_result.sum_gcd_pairs);
        }

        results
    }
}