use std::collections::HashMap;

struct FenwickTree {
    tree: Vec<i32>,
    size: usize,
}

impl FenwickTree {
    fn new(size: usize) -> Self {
        FenwickTree {
            tree: vec![0; size + 1], // Fenwick tree is 1-indexed
            size,
        }
    }

    // Adds `delta` to the element at `idx` (0-indexed)
    fn update(&mut self, mut idx: usize, delta: i32) {
        idx += 1; // Convert to 1-indexed
        while idx <= self.size {
            self.tree[idx] += delta;
            idx += idx & (!idx + 1); // idx += idx & (-idx)
        }
    }

    // Queries the sum of elements from index 0 to `idx` (0-indexed)
    fn query(&self, mut idx: usize) -> i32 {
        idx += 1; // Convert to 1-indexed
        let mut sum = 0;
        while idx > 0 {
            sum += self.tree[idx];
            idx -= idx & (!idx + 1); // idx -= idx & (-idx)
        }
        sum
    }
}

impl Solution {
    pub fn count_monotonic_pairs(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        if n <= 1 {
            return 0;
        }

        // Coordinate compression: Map each unique value to a rank (0-indexed)
        let mut sorted_unique_nums: Vec<i32> = nums.iter().cloned().collect();
        sorted_unique_nums.sort_unstable();
        sorted_unique_nums.dedup();

        let val_to_rank: HashMap<i32, usize> = sorted_unique_nums
            .iter()
            .enumerate()
            .map(|(rank, &val)| (val, rank))
            .collect();

        // Initialize Fenwick tree with size equal to the number of unique elements
        let mut ft = FenwickTree::new(sorted_unique_nums.len());
        let mut total_count: i64 = 0;

        // Iterate through the numbers and use the Fenwick tree to count pairs
        for &num in nums.iter() {
            let rank = *val_to_rank.get(&num).unwrap();

            // For the current `num` (at index `j`), query how many `nums[i]` (with `i < j`)
            // have `nums[i] <= num`. This is equivalent to querying the sum of counts
            // for all ranks up to `rank` in the Fenwick tree.
            total_count += ft.query(rank) as i64;

            // Add the current number to the Fenwick tree so it can be counted for
            // subsequent numbers (at index `k > j`).
            ft.update(rank, 1);
        }

        total_count
    }
}