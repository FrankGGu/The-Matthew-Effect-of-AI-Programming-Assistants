struct BookMyShow {
    n: i32,
    m: i32,
    seg_tree: Vec<(i64, i64)>,
}

impl BookMyShow {
    fn new(n: i32, m: i32) -> Self {
        let size = (n as usize).next_power_of_two() * 2;
        let mut seg_tree = vec![(0, 0); size];
        for i in 0..n as usize {
            seg_tree[i + size / 2] = (m as i64, m as i64);
        }
        for i in (1..size / 2).rev() {
            seg_tree[i] = (
                seg_tree[2 * i].0 + seg_tree[2 * i + 1].0,
                std::cmp::max(seg_tree[2 * i].1, seg_tree[2 * i + 1].1),
            );
        }
        BookMyShow { n, m, seg_tree }
    }

    fn update(&mut self, idx: usize, val: i64) {
        let mut pos = idx + self.seg_tree.len() / 2;
        self.seg_tree[pos] = (val, val);
        pos >>= 1;
        while pos > 0 {
            let left = 2 * pos;
            let right = 2 * pos + 1;
            self.seg_tree[pos] = (
                self.seg_tree[left].0 + self.seg_tree[right].0,
                std::cmp::max(self.seg_tree[left].1, self.seg_tree[right].1),
            );
            pos >>= 1;
        }
    }

    fn query_sum(&self, mut l: usize, mut r: usize) -> i64 {
        let mut res = 0;
        let n = self.seg_tree.len() / 2;
        l += n;
        r += n;
        while l <= r {
            if l % 2 == 1 {
                res += self.seg_tree[l].0;
                l += 1;
            }
            if r % 2 == 0 {
                res += self.seg_tree[r].0;
                r -= 1;
            }
            l /= 2;
            r /= 2;
        }
        res
    }

    fn query_max(&self, mut l: usize, mut r: usize) -> i64 {
        let mut res = 0;
        let n = self.seg_tree.len() / 2;
        l += n;
        r += n;
        while l <= r {
            if l % 2 == 1 {
                res = std::cmp::max(res, self.seg_tree[l].1);
                l += 1;
            }
            if r % 2 == 0 {
                res = std::cmp::max(res, self.seg_tree[r].1);
                r -= 1;
            }
            l /= 2;
            r /= 2;
        }
        res
    }

    fn gather(&mut self, k: i32, max_row: i32) -> Vec<i32> {
        let k = k as i64;
        let max_row = max_row as usize;
        let mut left = 0;
        let mut right = max_row;
        let mut found = None;
        while left <= right {
            let mid = (left + right) / 2;
            let max_seats = self.query_max(0, mid);
            if max_seats >= k {
                found = Some(mid);
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        if let Some(row) = found {
            let pos = row + self.seg_tree.len() / 2;
            let seats = self.seg_tree[pos].1;
            let col = (self.m as i64 - seats) as i32;
            self.update(row, seats - k);
            vec![row as i32, col]
        } else {
            vec![]
        }
    }

    fn scatter(&mut self, k: i32, max_row: i32) -> bool {
        let k = k as i64;
        let max_row = max_row as usize;
        let total = self.query_sum(0, max_row);
        if total < k {
            return false;
        }
        let mut remaining = k;
        let mut i = 0;
        while remaining > 0 {
            let pos = i + self.seg_tree.len() / 2;
            let seats = self.seg_tree[pos].1;
            let take = std::cmp::min(seats, remaining);
            self.update(i, seats - take);
            remaining -= take;
            i += 1;
        }
        true
    }
}