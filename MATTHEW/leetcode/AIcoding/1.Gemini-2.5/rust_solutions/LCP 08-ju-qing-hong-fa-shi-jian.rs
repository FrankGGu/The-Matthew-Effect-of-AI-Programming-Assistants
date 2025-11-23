use std::cmp::{min, Reverse};
use std::collections::HashMap;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum EventType {
    Growth,
    Query,
}

impl PartialOrd for EventType {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for EventType {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        match (self, other) {
            (EventType::Growth, EventType::Growth) => std::cmp::Ordering::Equal,
            (EventType::Growth, EventType::Query) => std::cmp::Ordering::Less,
            (EventType::Query, EventType::Growth) => std::cmp::Ordering::Greater,
            (EventType::Query, EventType::Query) => std::cmp::Ordering::Equal,
        }
    }
}

#[derive(Debug, Clone, Copy)]
struct Event {
    val: i32, // x-coordinate (g[0] or q[0])
    y_comp: usize,
    z_comp: usize,
    event_type: EventType,
    original_idx_or_day_idx: i32, // day_idx for Growth, query_idx for Query
}

struct SegmentTree {
    tree: Vec<i32>,
    size: usize,
    default_val: i32,
}

impl SegmentTree {
    fn new(n: usize, default_val: i32) -> Self {
        SegmentTree {
            tree: vec![default_val; 4 * n],
            size: n,
            default_val,
        }
    }

    fn update(&mut self, idx: usize, val: i32) {
        self._update(1, 0, self.size - 1, idx, val);
    }

    fn _update(&mut self, node: usize, start: usize, end: usize, idx: usize, val: i32) {
        if start == end {
            self.tree[node] = min(self.tree[node], val);
            return;
        }
        let mid = start + (end - start) / 2;
        if start <= idx && idx <= mid {
            self._update(2 * node, start, mid, idx, val);
        } else {
            self._update(2 * node + 1, mid + 1, end, idx, val);
        }
        self.tree[node] = min(self.tree[2 * node], self.tree[2 * node + 1]);
    }

    fn query(&mut self, l: usize, r: usize) -> i32 {
        self._query(1, 0, self.size - 1, l, r)
    }

    fn _query(&mut self, node: usize, start: usize, end: usize, l: usize, r: usize) -> i32 {
        if r < start || end < l {
            return self.default_val;
        }
        if l <= start && end <= r {
            return self.tree[node];
        }
        let mid = start + (end - start) / 2;
        let p1 = self._query(2 * node, start, mid, l, r);
        let p2 = self._query(2 * node + 1, mid + 1, end, l, r);
        min(p1, p2)
    }

    fn reset(&mut self, idx: usize) {
        self._reset(1, 0, self.size - 1, idx);
    }

    fn _reset(&mut self, node: usize, start: usize, end: usize, idx: usize) {
        if start == end {
            self.tree[node] = self.default_val;
            return;
        }
        let mid = start + (end - start) / 2;
        if start <= idx && idx <= mid {
            self._reset(2 * node, start, mid, idx);
        } else {
            self._reset(2 * node + 1, mid + 1, end, idx);
        }
        self.tree[node] = min(self.tree[2 * node], self.tree[2 * node + 1]);
    }
}

fn cdq_solve(
    events_slice: &mut [Event],
    ans: &mut [i32],
    max_z_comp_idx: usize,
    max_day_val: i32,
) {
    if events_slice.len() <= 1 {
        return;
    }

    let mid = events_slice.len() / 2;
    cdq_solve(&mut events_slice[0..mid], ans, max_z_comp_idx, max_day_val);
    cdq_solve(&mut events_slice[mid..], ans, max_z_comp_idx, max_day_val);

    events_slice[0..mid].sort_unstable_by_key(|e| Reverse(e.y_comp));
    events_slice[mid..].sort_unstable_by_key(|e| Reverse(e.y_comp));

    let mut segment_tree = SegmentTree::new(max_z_comp_idx + 1, max_day_val + 1);
    let mut updated_z_indices = Vec::new();

    let mut ptr_l = 0;
    let mut ptr_r = 0;

    let left_half_len = mid;
    let right_half_len = events_slice.len() - mid;

    while ptr_r < right_half_len {
        while ptr_l < left_half_len && events_slice[ptr_l].y_comp >= events_slice[mid + ptr_r].y_comp {
            if events_slice[ptr_l].event_type == EventType::Growth {
                segment_tree.update(events_slice[ptr_l].z_comp, events_slice[ptr_l].original_idx_or_day_idx);
                updated_z_indices.push(events_slice[ptr_l].z_comp);
            }
            ptr_l += 1;
        }

        if events_slice[mid + ptr_r].event_type == EventType::Query {
            let query_z_comp = events_slice[mid + ptr_r].z_comp;
            let min_day_found = segment_tree.query(query_z_comp, max_z_comp_idx);

            if min_day_found <= max_day_val {
                let query_idx = events_slice[mid + ptr_r].original_idx_or_day_idx as usize;
                if ans[query_idx] == -1 || min_day_found < ans[query_idx] {
                    ans[query_idx] = min_day_found;
                }
            }
        }
        ptr_r += 1;
    }

    for &z_idx in &updated_z_indices {
        segment_tree.reset(z_idx);
    }

    events_slice.sort_unstable_by_key(|e| Reverse(e.val));
}

impl Solution {
    pub fn get_trigger_time(growth: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = growth.len();
        let m = queries.len();

        let mut y_coords = Vec::new();
        let mut z_coords = Vec::new();
        for g in &growth {
            y_coords.push(g[1]);
            z_coords.push(g[2]);
        }
        for q in &queries {
            y_coords.push(q[1]);
            z_coords.push(q[2]);
        }

        y_coords.sort_unstable();
        y_coords.dedup();
        z_coords.sort_unstable();
        z_coords.dedup();

        let get_y_comp = |val: i32| y_coords.binary_search(&val).unwrap();
        let get_z_comp = |val: i32| z_coords.binary_search(&val).unwrap();

        let max_z_comp_idx = if z_coords.is_empty() { 0 } else { z_coords.len() - 1 };

        let mut events: Vec<Event> = Vec::with_capacity(n + m);
        for i in 0..n {
            events.push(Event {
                val: growth[i][0],
                y_comp: get_y_comp(growth[i][1]),
                z_comp: get_z_comp(growth[i][2]),
                event_type: EventType::Growth,
                original_idx_or_day_idx: i as i32,
            });
        }
        for i in 0..m {
            events.push(Event {
                val: queries[i][0],
                y_comp: get_y_comp(queries[i][1]),
                z_comp: get_z_comp(queries[i][2]),
                event_type: EventType::Query,
                original_idx_or_day_idx: i as i32,
            });
        }

        events.sort_unstable_by(|a, b| {
            if a.val != b.val {
                b.val.cmp(&a.val)
            } else {
                a.event_type.cmp(&b.event_type)
            }
        });

        let mut ans = vec![-1; m];

        cdq_solve(&mut events, &mut ans, max_z_comp_idx, n as i32);

        ans
    }
}