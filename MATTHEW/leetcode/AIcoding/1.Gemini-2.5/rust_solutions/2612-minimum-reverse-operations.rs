use std::collections::{VecDeque, BTreeSet};
use std::cmp::{min, max};

impl Solution {
    pub fn minimum_reverse_operations(n: i32, p: Vec<i32>, start: i32, k: i32) -> Vec<i32> {
        let n_usize = n as usize;

        let mut ans = vec![-1; n_usize];
        let mut is_blocked = vec![false; n_usize];
        for &pos in &p {
            is_blocked[pos as usize] = true;
        }

        let mut q: VecDeque<i32> = VecDeque::new();
        let mut unvisited_even: BTreeSet<i32> = BTreeSet::new();
        let mut unvisited_odd: BTreeSet<i32> = BTreeSet::new();

        for i in 0..n {
            if !is_blocked[i as usize] {
                if i % 2 == 0 {
                    unvisited_even.insert(i);
                } else {
                    unvisited_odd.insert(i);
                }
            }
        }

        ans[start as usize] = 0;
        q.push_back(start);
        if start % 2 == 0 {
            unvisited_even.remove(&start);
        } else {
            unvisited_odd.remove(&start);
        }

        while let Some(u) = q.pop_front() {
            let current_dist = ans[u as usize];

            // Calculate the range of 'l' (start index of the subarray to reverse)
            // A subarray [l, l + k - 1] is reversed.
            // Constraints on l:
            // 1. 0 <= l
            // 2. l + k - 1 < n  =>  l <= n - k
            // 3. u must be within the subarray [l, l + k - 1]:
            //    l <= u  AND  u <= l + k - 1  =>  l >= u - k + 1
            let l_min = max(0, u - k + 1);
            let l_max = min(u, n - k);

            // The new position 'v' after reversing [l, l+k-1] is l + ( (l+k-1) - u ) = 2*l + k - 1 - u
            // Calculate the range of 'v' based on the range of 'l'
            let v_lower = 2 * l_min + k - 1 - u;
            let v_upper = 2 * l_max + k - 1 - u;

            // Determine which BTreeSet to query based on parity.
            // v - u = 2*l + k - 1 - 2*u.
            // The parity of (v - u) is the same as (k - 1).
            // If k is odd, (k - 1) is even, so v and u have the same parity.
            // If k is even, (k - 1) is odd, so v and u have different parities.
            let target_set = if (k % 2 == 1 && u % 2 == 0) || (k % 2 == 0 && u % 2 == 1) {
                // Case 1: k is odd, u is even. v must be even.
                // Case 2: k is even, u is odd. v must be even.
                &mut unvisited_even
            } else {
                // Case 3: k is odd, u is odd. v must be odd.
                // Case 4: k is even, u is even. v must be odd.
                &mut unvisited_odd
            };

            // Collect nodes to process within the range [v_lower, v_upper].
            // We collect them first because we cannot modify the BTreeSet while iterating its range.
            let mut nodes_to_process: Vec<i32> = Vec::new();
            for &v in target_set.range(v_lower..=v_upper) {
                nodes_to_process.push(v);
            }

            // Process collected nodes: mark visited, update distance, add to queue.
            for v in nodes_to_process {
                target_set.remove(&v); // Mark as visited by removing from the set
                ans[v as usize] = current_dist + 1;
                q.push_back(v);
            }
        }

        ans
    }
}