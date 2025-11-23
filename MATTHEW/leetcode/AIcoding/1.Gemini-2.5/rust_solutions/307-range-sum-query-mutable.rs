struct NumArray {
    n: usize,
    tree: Vec<i32>,
}

impl NumArray {
    fn new(nums: Vec<i32>) -> Self {
        let n = nums.len();
        if n == 0 {
            return NumArray { n: 0, tree: Vec::new() };
        }

        let mut tree = vec![0; 4 * n]; // Max size for segment tree
        let mut num_array = NumArray { n, tree };
        num_array.build(1, 0, n - 1, &nums);
        num_array
    }

    fn build(&mut self, tree_idx: usize, range_start: usize, range_end: usize, nums: &[i32]) {
        if range_start == range_end {
            self.tree[tree_idx] = nums[range_start];
        } else {
            let mid = range_start + (range_end - range_start) / 2;
            self.build(2 * tree_idx, range_start, mid, nums);
            self.build(2 * tree_idx + 1, mid + 1, range_end, nums);
            self.tree[tree_idx] = self.tree[2 * tree_idx] + self.tree[2 * tree_idx + 1];
        }
    }

    fn update(&mut self, index: i32, val: i32) {
        if self.n == 0 {
            return;
        }
        self._update(1, 0, self.n - 1, index as usize, val);
    }

    fn _update(&mut self, tree_idx: usize, range_start: usize, range_end: usize, index_to_update: usize, val: i32) {
        if range_start == range_end {
            self.tree[tree_idx] = val;
            return;
        }

        let mid = range_start + (range_end - range_start) / 2;
        if index_to_update <= mid {
            self._update(2 * tree_idx, range_start, mid, index_to_update, val);
        } else {
            self._update(2 * tree_idx + 1, mid + 1, range_end, index_to_update, val);
        }
        self.tree[tree_idx] = self.tree[2 * tree_idx] + self.tree[2 * tree_idx + 1];
    }

    fn sum_range(&self, left: i32, right: i32) -> i32 {
        if self.n == 0 {
            return 0;
        }
        self._query(1, 0, self.n - 1, left as usize, right as usize)
    }

    fn _query(&self, tree_idx: usize, range_start: usize, range_end: usize, query_left: usize, query_right: usize) -> i32 {
        // Current segment completely within query range
        if query_left <= range_start && range_end <= query_right {
            return self.tree[tree_idx];
        }

        // Current segment completely outside query range
        if range_end < query_left || query_right < range_start {
            return 0;
        }

        // Current segment partially overlaps query range
        let mid = range_start + (range_end - range_start) / 2;
        let left_sum = self._query(2 * tree_idx, range_start, mid, query_left, query_right);
        let right_sum = self._query(2 * tree_idx + 1, mid + 1, range_end, query_left, query_right);
        left_sum + right_sum
    }
}