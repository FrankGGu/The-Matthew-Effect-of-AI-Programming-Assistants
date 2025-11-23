struct SegmentTree {
    tree: Vec<i32>,
    n: usize,
}

impl SegmentTree {
    fn new(heights: &[i32]) -> Self {
        let n = heights.len();
        let mut tree = vec![0; 4 * n];
        let mut s = SegmentTree { tree, n };
        s.build(1, 0, n - 1, heights);
        s
    }

    fn build(&mut self, node: usize, start: usize, end: usize, heights: &[i32]) {
        if start == end {
            self.tree[node] = heights[start];
        } else {
            let mid = start + (end - start) / 2;
            self.build(2 * node, start, mid, heights);
            self.build(2 * node + 1, mid + 1, end, heights);
            self.tree[node] = self.tree[2 * node].max(self.tree[2 * node + 1]);
        }
    }

    fn query(&self, node: usize, start: usize, end: usize, query_l: usize, query_r: usize, h_req: i32) -> i32 {
        if start > query_r || end < query_l {
            return -1;
        }

        if self.tree[node] <= h_req {
            return -1;
        }

        if start == end {
            return start as i32;
        }

        let mid = start + (end - start) / 2;

        let res_left = self.query(2 * node, start, mid, query_l, query_r, h_req);
        if res_left != -1 {
            return res_left;
        }

        let res_right = self.query(2 * node + 1, mid + 1, end, query_l, query_r, h_req);
        res_right
    }
}

impl Solution {
    pub fn find_building(heights: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = heights.len();
        let segment_tree = SegmentTree::new(&heights);
        let mut ans = Vec::with_capacity(queries.len());

        for query in queries {
            let alice_idx = query[0] as usize;
            let bob_idx = query[1] as usize;

            let start_idx = alice_idx.max(bob_idx);
            let h_req = heights[alice_idx].max(heights[bob_idx]);

            let result = segment_tree.query(1, 0, n - 1, start_idx, n - 1, h_req);
            ans.push(result);
        }

        ans
    }
}