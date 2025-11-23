use std::collections::VecDeque;

struct FenwickTree {
    size: usize,
    tree: Vec<i32>,
}

impl FenwickTree {
    fn new(n: usize) -> Self {
        let mut ft = FenwickTree {
            size: n,
            tree: vec![0; n + 1],
        };
        // Initialize with all 1s, meaning all elements are initially available
        for i in 0..n {
            ft.update_internal(i + 1, 1);
        }
        ft
    }

    // Internal update function using 1-based indexing for the tree
    fn update_internal(&mut self, mut idx: usize, delta: i32) {
        while idx <= self.size {
            self.tree[idx] += delta;
            idx += idx & (!idx + 1);
        }
    }

    // Public update function for 0-based index
    fn update(&mut self, idx: usize, delta: i32) {
        self.update_internal(idx + 1, delta);
    }

    // Public query function for 0-based index (prefix sum up to idx-1)
    fn query(&self, mut idx: usize) -> i32 {
        let mut sum = 0;
        // Adjust idx to be 1-based for BIT query up to original_idx-1
        // If query(0), it means sum up to -1, which is 0.
        // If query(original_idx), it means sum up to original_idx-1
        while idx > 0 {
            sum += self.tree[idx];
            idx -= idx & (!idx + 1);
        }
        sum
    }
}

impl Solution {
    pub fn min_integer(num: String, k: i32) -> String {
        let n = num.len();
        let num_chars: Vec<char> = num.chars().collect();

        let mut digit_indices: Vec<VecDeque<usize>> = vec![VecDeque::new(); 10];
        for (idx, &c) in num_chars.iter().enumerate() {
            digit_indices[c as usize - '0' as usize].push_back(idx);
        }

        let mut bit = FenwickTree::new(n);
        let mut result = String::with_capacity(n);
        let mut k_remaining = k;

        for i in 0..n {
            // i is the current target position (0-indexed) in the result string
            if k_remaining == 0 {
                // If no more swaps allowed, append remaining digits in their original relative order
                break;
            }

            for d in 0..10 {
                // Try digits '0' through '9'
                if let Some(&original_idx) = digit_indices[d].front() {
                    // Calculate cost to move this digit (at original_idx) to the current position i
                    // The cost is the number of available elements between the current target position i
                    // and the original_idx.
                    // bit.query(original_idx) gives count of available elements at original indices 0 to original_idx-1.
                    // bit.query(i) gives count of available elements at original indices 0 to i-1.
                    // So, bit.query(original_idx) - bit.query(i) is count of available elements at original indices i to original_idx-1.
                    let cost = bit.query(original_idx) - bit.query(i);

                    if cost <= k_remaining {
                        result.push((d as u8 + b'0') as char);
                        k_remaining -= cost;
                        digit_indices[d].pop_front();
                        bit.update(original_idx, -1); // Mark this element as used
                        break; // Found the best digit for this position, move to the next result position
                    }
                }
            }
        }

        // Append any remaining characters if k_remaining became 0 or all positions filled
        for j in 0..n {
            // Check if num_chars[j] is still available
            // bit.query(j + 1) - bit.query(j) == 1 means original_idx j is available
            if bit.query(j + 1) - bit.query(j) == 1 {
                result.push(num_chars[j]);
            }
        }

        result
    }
}