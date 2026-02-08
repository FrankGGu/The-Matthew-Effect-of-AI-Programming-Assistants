struct FenwickTree {
    tree: Vec<i32>,
    n: usize,
}

impl FenwickTree {
    fn new(size: usize) -> Self {
        let mut ft = FenwickTree {
            tree: vec![0; size + 1],
            n: size,
        };
        for i in 0..size {
            ft.update(i, 1);
        }
        ft
    }

    fn update(&mut self, mut idx: usize, delta: i32) {
        idx += 1;
        while idx <= self.n {
            self.tree[idx] += delta;
            idx += idx & idx.wrapping_neg();
        }
    }

    fn query_sum(&self, mut idx: usize) -> i32 {
        idx += 1;
        let mut sum = 0;
        while idx > 0 {
            sum += self.tree[idx];
            idx -= idx & idx.wrapping_neg();
        }
        sum
    }
}

impl Solution {
    pub fn make_array_empty(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut pairs: Vec<(i32, usize)> = nums
            .into_iter()
            .enumerate()
            .map(|(i, val)| (val, i))
            .collect();

        pairs.sort_by_key(|&(val, _)| val);

        let mut ft = FenwickTree::new(n);
        let mut total_cost: i64 = 0;
        let mut current_idx_in_remaining: i32 = 0;

        for &(_val, original_idx) in pairs.iter() {
            let num_remaining = ft.query_sum(n - 1);

            let rank_of_original_idx = ft.query_sum(original_idx); 

            let mut i = (rank_of_original_idx - 1 - current_idx_in_remaining + num_remaining) % num_remaining;
            i = (i + num_remaining) % num_remaining;

            total_cost += (i + 1) as i64;

            ft.update(original_idx, -1);

            if num_remaining > 1 {
                current_idx_in_remaining = (current_idx_in_remaining + i) % (num_remaining - 1);
            } else {
                current_idx_in_remaining = 0;
            }
        }

        total_cost
    }
}