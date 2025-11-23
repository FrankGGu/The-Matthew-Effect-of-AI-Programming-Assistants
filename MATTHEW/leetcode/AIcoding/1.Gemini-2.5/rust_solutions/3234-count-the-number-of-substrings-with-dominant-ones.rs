struct FenwickTree {
    tree: Vec<i32>,
    size: usize,
}

impl FenwickTree {
    fn new(size: usize) -> Self {
        FenwickTree {
            tree: vec![0; size + 1], // 1-indexed internally
            size,
        }
    }

    // Add `val` to the element at `idx` (0-indexed for user, converted to 1-indexed internally)
    fn update(&mut self, mut idx: usize, val: i32) {
        idx += 1; // Convert to 1-indexed
        while idx <= self.size {
            self.tree[idx] += val;
            idx += idx & (!idx + 1); // Equivalent to idx += idx & (-idx)
        }
    }

    // Get sum of elements from 0 to `idx` (0-indexed for user, converted to 1-indexed internally)
    fn query(&self, mut idx: usize) -> i32 {
        idx += 1; // Convert to 1-indexed
        let mut sum = 0;
        while idx > 0 {
            sum += self.tree[idx];
            idx -= idx & (!idx + 1); // Equivalent to idx -= idx & (-idx)
        }
        sum
    }
}

impl Solution {
    pub fn count_subarrays_with_dominant_ones(s: String) -> i64 {
        let n = s.len();
        if n == 0 {
            return 0;
        }

        // Offset to map prefix sums [-n, n] to [0, 2n] for Fenwick Tree indices
        let offset = n as i32;
        // Fenwick Tree size needs to cover indices from 0 to 2*n
        let mut ft = FenwickTree::new(2 * n + 1);

        let mut current_sum: i32 = 0; // Represents P[j+1]
        let mut ans: i64 = 0;

        // P[0] = 0. Add its count to Fenwick Tree.
        // Map 0 to 0 + offset.
        ft.update(offset as usize, 1);

        for c in s.chars() {
            if c == '1' {
                current_sum += 1;
            } else {
                current_sum -= 1;
            }

            // We need to count P[i] such that P[i] < current_sum.
            // These P[i] values are stored in the Fenwick Tree.
            // The index for Fenwick tree corresponding to `current_sum - 1` is `(current_sum - 1) + offset`.
            // We need to query for sum up to this index (inclusive).
            // Ensure the index is non-negative.
            let query_idx = (current_sum - 1 + offset).max(0) as usize;
            ans += ft.query(query_idx) as i64;

            // Add current_sum (P[j+1]) to Fenwick Tree.
            // Map current_sum to current_sum + offset.
            ft.update((current_sum + offset) as usize, 1);
        }

        ans
    }
}