impl Solution {
    fn sum_digits(mut n: i32) -> i32 {
        let mut sum = 0;
        if n == 0 {
            return 0;
        }
        while n > 0 {
            sum += n % 10;
            n /= 10;
        }
        sum
    }

    pub fn min_swaps_by_digit_sum(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 1 {
            return 0;
        }

        let mut pairs: Vec<(i32, usize)> = Vec::with_capacity(n);
        for (i, &num) in nums.iter().enumerate() {
            pairs.push((Self::sum_digits(num), i));
        }

        // Sort the pairs. The primary sort key is digit sum,
        // and the secondary sort key is the original index for tie-breaking.
        // This ensures a unique target sorted state.
        pairs.sort_unstable_by_key(|&(ds, oi)| (ds, oi));

        // Create a mapping from original index to its target sorted index.
        // `pos_map[original_index]` will store the index `j` such that
        // the element with `original_index` should be at position `j` in the sorted array.
        let mut pos_map: Vec<usize> = vec![0; n];
        for i in 0..n {
            pos_map[pairs[i].1] = i;
        }

        let mut visited: Vec<bool> = vec![false; n];
        let mut swaps = 0;

        // Iterate through the original indices (0 to n-1)
        // to find cycles in the permutation defined by `pos_map`.
        for i in 0..n {
            // If this original index `i` has already been visited as part of a cycle, skip.
            // Or if the element originally at `i` is already in its correct sorted position.
            if visited[i] {
                continue;
            }

            // Start a new cycle
            let mut cycle_len = 0;
            let mut current_node = i; // `current_node` represents an original index

            while !visited[current_node] {
                visited[current_node] = true;
                cycle_len += 1;
                // Move to the next original index in the cycle.
                // `pos_map[current_node]` gives the target sorted position of the element
                // that was originally at `current_node`.
                // The element that *should* be at `current_node`'s target position
                // is the one whose original index is `current_node`.
                // We are following the chain: original_index_A -> original_index_B -> ...
                current_node = pos_map[current_node];
            }

            // A cycle of length L requires L-1 swaps to sort.
            if cycle_len > 0 {
                swaps += (cycle_len - 1) as i32;
            }
        }

        swaps
    }
}