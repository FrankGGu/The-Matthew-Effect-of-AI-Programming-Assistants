struct Node {
    sum_zeros: i64,
    sum_ones: i64,
    num_zeros: i32,
    num_ones: i32,
    lazy_flip: bool,
}

impl Node {
    fn new() -> Self {
        Node {
            sum_zeros: 0,
            sum_ones: 0,
            num_zeros: 0,
            num_ones: 0,
            lazy_flip: false,
        }
    }
}

struct SegmentTree {
    tree: Vec<Node>,
    nums1_initial: Vec<i32>, // Store initial nums1 for building
    nums2_initial: Vec<i64>, // Store initial nums2 for building
    n: usize,
}

impl SegmentTree {
    fn new(nums1: Vec<i32>, nums2: Vec<i64>) -> Self {
        let n = nums1.len();
        let mut seg_tree = SegmentTree {
            tree: vec![Node::new(); 4 * n],
            nums1_initial: nums1,
            nums2_initial: nums2,
            n,
        };
        seg_tree.build(1, 0, n - 1);
        seg_tree
    }

    fn combine(left: &Node, right: &Node) -> Node {
        Node {
            sum_zeros: left.sum_zeros + right.sum_zeros,
            sum_ones: left.sum_ones + right.sum_ones,
            num_zeros: left.num_zeros + right.num_zeros,
            num_ones: left.num_ones + right.num_ones,
            lazy_flip: false, // Lazy flag is handled by push_down, not combined
        }
    }

    fn apply_flip(node: &mut Node) {
        std::mem::swap(&mut node.sum_zeros, &mut node.sum_ones);
        std::mem::swap(&mut node.num_zeros, &mut node.num_ones);
        node.lazy_flip = !node.lazy_flip;
    }

    fn build(&mut self, node_idx: usize, start: usize, end: usize) {
        if start == end {
            if self.nums1_initial[start] == 0 {
                self.tree[node_idx].sum_zeros = self.nums2_initial[start];
                self.tree[node_idx].num_zeros = 1;
            } else {
                self.tree[node_idx].sum_ones = self.nums2_initial[start];
                self.tree[node_idx].num_ones = 1;
            }
        } else {
            let mid = start + (end - start) / 2;
            self.build(2 * node_idx, start, mid);
            self.build(2 * node_idx + 1, mid + 1, end);
            self.tree[node_idx] = Self::combine(&self.tree[2 * node_idx], &self.tree[2 * node_idx + 1]);
        }
    }

    fn push_down(&mut self, node_idx: usize) {
        if self.tree[node_idx].lazy_flip {
            Self::apply_flip(&mut self.tree[2 * node_idx]);
            Self::apply_flip(&mut self.tree[2 * node_idx + 1]);
            self.tree[node_idx].lazy_flip = false;
        }
    }

    fn update_range(&mut self, node_idx: usize, start: usize, end: usize, query_l: usize, query_r: usize) {
        if start > query_r || end < query_l {
            return;
        }

        if query_l <= start && end <= query_r {
            Self::apply_flip(&mut self.tree[node_idx]);
            return;
        }

        self.push_down(node_idx);
        let mid = start + (end - start) / 2;
        self.update_range(2 * node_idx, start, mid, query_l, query_r);
        self.update_range(2 * node_idx + 1, mid + 1, end, query_l, query_r);

        self.tree[node_idx] = Self::combine(&self.tree[2 * node_idx], &self.tree[2 * node_idx + 1]);
    }

    fn query_sum_ones(&mut self, node_idx: usize, start: usize, end: usize, query_l: usize, query_r: usize) -> i64 {
        if start > query_r || end < query_l {
            return 0;
        }

        if query_l <= start && end <= query_r {
            return self.tree[node_idx].sum_ones;
        }

        self.push_down(node_idx);
        let mid = start + (end - start) / 2;
        let p1 = self.query_sum_ones(2 * node_idx, start, mid, query_l, query_r);
        let p2 = self.query_sum_ones(2 * node_idx + 1, mid + 1, end, query_l, query_r);
        p1 + p2
    }
}

impl Solution {
    pub fn handle_query(nums1: Vec<i32>, nums2: Vec<i64>, queries: Vec<Vec<i32>>) -> Vec<i64> {
        let n = nums1.len();

        let total_sum_of_all_nums2: i64 = nums2.iter().sum();
        let mut seg_tree = SegmentTree::new(nums1, nums2);

        let mut results = Vec::new();

        for query in queries {
            let type_ = query[0];
            let l = query[1] as usize;
            let r_or_p = query[2];

            if type_ == 0 {
                seg_tree.update_range(1, 0, n - 1, l, r_or_p as usize);
            } else if type_ == 1 {
                let sum_in_range = seg_tree.query_sum_ones(1, 0, n - 1, l, r_or_p as usize);
                results.push(sum_in_range);
            } else { // type_ == 2
                let p = l as i64;
                let total_sum_nums2_where_nums1_is_one = seg_tree.query_sum_ones(1, 0, n - 1, 0, n - 1);
                results.push(p * total_sum_of_all_nums2 + total_sum_nums2_where_nums1_is_one);
            }
        }
        results
    }
}