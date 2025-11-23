use std::cmp::{min, max};

struct Node {
    min_avail: i64,
    sum_avail: i64,
}

struct BookMyShow {
    n_rows: i32,
    m_seats_per_row: i64,
    next_available_row: i32,
    seats_taken_in_row: Vec<i64>,
    tree: Vec<Node>,
}

impl BookMyShow {
    fn new(n: i32, m: i32) -> Self {
        let n_usize = n as usize;
        let m_long = m as i64;
        let mut bms = BookMyShow {
            n_rows: n,
            m_seats_per_row: m_long,
            next_available_row: 0,
            seats_taken_in_row: vec![0; n_usize],
            tree: vec![Node { min_avail: 0, sum_avail: 0 }; 4 * n_usize],
        };
        bms.build(1, 0, n - 1);
        bms
    }

    fn build(&mut self, node_idx: usize, range_start: i32, range_end: i32) {
        if range_start == range_end {
            self.tree[node_idx] = Node {
                min_avail: self.m_seats_per_row,
                sum_avail: self.m_seats_per_row,
            };
        } else {
            let mid = range_start + (range_end - range_start) / 2;
            self.build(2 * node_idx, range_start, mid);
            self.build(2 * node_idx + 1, mid + 1, range_end);
            self.tree[node_idx] = Node {
                min_avail: min(self.tree[2 * node_idx].min_avail, self.tree[2 * node_idx + 1].min_avail),
                sum_avail: self.tree[2 * node_idx].sum_avail + self.tree[2 * node_idx + 1].sum_avail,
            };
        }
    }

    fn update(&mut self, node_idx: usize, range_start: i32, range_end: i32, row_idx: i32, seats_to_add: i64) {
        if range_start == range_end {
            self.seats_taken_in_row[row_idx as usize] += seats_to_add;
            self.tree[node_idx].min_avail = self.m_seats_per_row - self.seats_taken_in_row[row_idx as usize];
            self.tree[node_idx].sum_avail = self.m_seats_per_row - self.seats_taken_in_row[row_idx as usize];
        } else {
            let mid = range_start + (range_end - range_start) / 2;
            if row_idx <= mid {
                self.update(2 * node_idx, range_start, mid, row_idx, seats_to_add);
            } else {
                self.update(2 * node_idx + 1, mid + 1, range_end, row_idx, seats_to_add);
            }
            self.tree[node_idx] = Node {
                min_avail: min(self.tree[2 * node_idx].min_avail, self.tree[2 * node_idx + 1].min_avail),
                sum_avail: self.tree[2 * node_idx].sum_avail + self.tree[2 * node_idx + 1].sum_avail,
            };
        }
    }

    fn query_first_row_with_k_seats(&self, node_idx: usize, range_start: i32, range_end: i32, k_seats: i64, query_start_idx: i32) -> Option<i32> {
        if range_end < query_start_idx || self.tree[node_idx].min_avail < k_seats {
            return None;
        }
        if range_start == range_end {
            return Some(range_start);
        }

        let mid = range_start + (range_end - range_start) / 2;
        let res = self.query_first_row_with_k_seats(2 * node_idx, range_start, mid, k_seats, query_start_idx);
        if res.is_some() {
            return res;
        } else {
            return self.query_first_row_with_k_seats(2 * node_idx + 1, mid + 1, range_end, k_seats, query_start_idx);
        }
    }

    fn query_first_partially_filled_row(&self, node_idx: usize, range_start: i32, range_end: i32, query_start_idx: i32) -> Option<i32> {
        if range_end < query_start_idx || self.tree[node_idx].sum_avail == 0 {
            return None;
        }
        if range_start == range_end {
            return Some(range_start);
        }

        let mid = range_start + (range_end - range_start) / 2;
        let mut res = None;
        if mid >= query_start_idx {
            res = self.query_first_partially_filled_row(2 * node_idx, range_start, mid, query_start_idx);
        }
        if res.is_some() {
            return res;
        } else {
            return self.query_first_partially_filled_row(2 * node_idx + 1, mid + 1, range_end, query_start_idx);
        }
    }

    fn query_sum_available(&self, node_idx: usize, range_start: i32, range_end: i32, query_start: i32, query_end: i32) -> i64 {
        if query_start > range_end || query_end < range_start {
            return 0;
        }
        let current_query_start = max(query_start, range_start);
        let current_query_end = min(query_end, range_end);

        if current_query_start == range_start && current_query_end == range_end {
            return self.tree[node_idx].sum_avail;
        }

        let mid = range_start + (range_end - range_start) / 2;
        let left_sum = self.query_sum_available(2 * node_idx, range_start, mid, current_query_start, current_query_end);
        let right_sum = self.query_sum_available(2 * node_idx + 1, mid + 1, range_end, current_query_start, current_query_end);
        left_sum + right_sum
    }

    fn gather(&mut self, k: i32) -> Vec<i32> {
        let k_long = k as i64;
        let target_row_option = self.query_first_row_with_k_seats(1, 0, self.n_rows - 1, k_long, self.next_available_row);

        if target_row_option.is_none() {
            return vec![];
        }

        let row_idx = target_row_option.unwrap();
        let col_start = self.seats_taken_in_row[row_idx as usize] as i32;
        self.update(1, 0, self.n_rows - 1, row_idx, k_long);

        vec![row_idx, col_start]
    }

    fn scatter(&mut self, k: i32) -> bool {
        let mut seats_to_distribute = k as i64;

        let total_available_from_next = self.query_sum_available(1, 0, self.n_rows - 1, self.next_available_row, self.n_rows - 1);
        if total_available_from_next < seats_to_distribute {
            return false;
        }

        while seats_to_distribute > 0 {
            let current_row_idx_option = self.query_first_partially_filled_row(1, 0, self.n_rows - 1, self.next_available_row);

            // This should not be None if total_available_from_next was sufficient
            let current_row_idx = current_row_idx_option.unwrap(); 

            let available_in_row = self.m_seats_per_row - self.seats_taken_in_row[current_row_idx as usize];
            let take = min(seats_to_distribute, available_in_row);

            self.update(1, 0, self.n_rows - 1, current_row_idx, take);
            seats_to_distribute -= take;
        }

        self.next_available_row = self.query_first_partially_filled_row(1, 0, self.n_rows - 1, self.next_available_row).unwrap_or(self.n_rows);
        true
    }
}