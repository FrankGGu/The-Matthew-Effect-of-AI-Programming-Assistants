use std::collections::BinaryHeap;
use std::cmp::Reverse;

fn gcd(a: u64, b: u64) -> u64 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}

fn array_gcd(arr: &[i32]) -> u64 {
    if arr.is_empty() {
        // According to problem constraints, n >= 1, so this case should not be reached.
        // Returning 0 or panicking would be appropriate for an invalid input.
        return 0; 
    }
    let mut result = arr[0] as u64;
    for &num in arr.iter().skip(1) {
        result = gcd(result, num as u64);
        if result == 1 {
            return 1; // Optimization: if gcd is 1, it won't get smaller
        }
    }
    result
}

struct Solution;

impl Solution {
    pub fn kth_smallest_amount(k: i32, denominations: Vec<i32>) -> i64 {
        let mut denoms_u64: Vec<u64> = denominations.iter().map(|&d| d as u64).collect();
        // Sort to ensure denoms_u64[0] is the smallest denomination (after GCD division)
        // This is important for the Dijkstra modulo approach.
        denoms_u64.sort_unstable(); 

        let original_gcd = array_gcd(&denominations);

        // If, after dividing by the overall GCD, the smallest denomination becomes 1,
        // it means all multiples of the original_gcd can be formed.
        // In this case, the k-th smallest amount is simply k * original_gcd.
        // This covers cases where 1 is in the original denominations, or if the GCD
        // of all denominations is itself the smallest denomination.
        if denoms_u64[0] / original_gcd == 1 {
            return k as i64 * original_gcd as i64;
        }

        // Divide all denominations by their GCD to simplify the problem.
        // All formable amounts will be multiples of original_gcd.
        // We find the k-th smallest amount A' for the simplified denominations,
        // then the final answer is A' * original_gcd.
        for d in denoms_u64.iter_mut() {
            *d /= original_gcd;
        }

        // The smallest denomination in the simplified set.
        // It's guaranteed to be denoms_u64[0] because we sorted it.
        let d0 = denoms_u64[0];

        // Dijkstra to find the minimum sum for each remainder modulo d0.
        // dist[r] stores the minimum amount `S` that can be formed
        // such that `S % d0 = r`.
        // Initialize with u64::MAX for unreachable states.
        let mut dist: Vec<u64> = vec![u64::MAX; d0 as usize];
        // Priority queue stores (Reverse(cost), remainder) to get min-heap behavior.
        let mut pq = BinaryHeap::new(); 

        // The amount 0 can always be formed (by taking no denominations).
        // It has remainder 0 modulo d0.
        dist[0] = 0;
        pq.push(Reverse((0, 0))); // (cost, remainder)

        while let Some(Reverse((cost, u))) = pq.pop() {
            // If we found a shorter path to `u` already, skip this entry.
            if cost > dist[u as usize] {
                continue;
            }

            // Explore neighbors using each denomination d_j
            for &d_j in denoms_u64.iter() {
                let v = (u + d_j) % d0; // New remainder
                let new_cost = cost + d_j; // New total sum

                // If this path is shorter, update and push to PQ.
                if new_cost < dist[v as usize] {
                    dist[v as usize] = new_cost;
                    pq.push(Reverse((new_cost, v)));
                }
            }
        }

        // Binary search for the k-th smallest amount `X` (in the simplified problem).
        let mut low: u64 = 1;
        // A safe upper bound for the search space: k * max_denomination (after GCD division).
        // Max k = 10^9, max d_i (after division) could be 10^5. So max_ans could be 10^14.
        // A generous constant upper bound is also fine.
        let mut high: u64 = 2_000_000_000_000_000_u64; // Approx 2 * 10^15, well above 10^14

        let mut ans: u64 = high; // Initialize answer to a large value

        while low <= high {
            let mid = low + (high - low) / 2;

            // Calculate the number of distinct positive amounts <= mid.
            // For each remainder `r` modulo `d0`, amounts are `dist[r], dist[r] + d0, dist[r] + 2*d0, ...`
            // We count how many of these are <= mid.
            let mut count: u64 = 0;
            for r in 0..d0 {
                if dist[r as usize] <= mid {
                    // Number of terms: (mid - dist[r]) / d0 + 1 (for 0-indexed terms)
                    count += (mid - dist[r as usize]) / d0 + 1;
                }
            }

            // The Dijkstra algorithm includes 0 as a formable amount (dist[0] = 0).
            // Since the problem asks for positive amounts, we subtract 1 from the total count
            // to exclude 0 itself.
            count -= 1; 

            if count >= k as u64 {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        // Multiply the result from the simplified problem by the original GCD
        // to get the final answer.
        (ans * original_gcd) as i64
    }
}