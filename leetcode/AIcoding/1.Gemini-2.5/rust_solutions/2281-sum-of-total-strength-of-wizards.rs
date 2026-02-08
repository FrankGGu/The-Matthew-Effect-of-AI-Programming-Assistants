use std::collections::VecDeque;

impl Solution {
    pub fn total_strength(strength: Vec<i32>) -> i32 {
        let n = strength.len();
        let modulo: i64 = 1_000_000_007;

        // Calculate left_smaller: index of previous strictly smaller element
        // If no such element, it's -1
        let mut left_smaller = vec![-1i32; n];
        let mut stack: VecDeque<usize> = VecDeque::new();
        for i in 0..n {
            while let Some(&top_idx) = stack.back() {
                if strength[top_idx] >= strength[i] {
                    stack.pop_back();
                } else {
                    break;
                }
            }
            if let Some(&top_idx) = stack.back() {
                left_smaller[i] = top_idx as i32;
            }
            stack.push_back(i);
        }

        // Calculate right_smaller_equal: index of next smaller or equal element
        // If no such element, it's n
        let mut right_smaller_equal = vec![n as i32; n];
        stack.clear();
        for i in (0..n).rev() {
            while let Some(&top_idx) = stack.back() {
                if strength[top_idx] > strength[i] { // Note: strictly greater for NSEE
                    stack.pop_back();
                } else {
                    break;
                }
            }
            if let Some(&top_idx) = stack.back() {
                right_smaller_equal[i] = top_idx as i32;
            }
            stack.push_back(i);
        }

        // Calculate prefix sums (P) and prefix sums of prefix sums (PP)
        // P[x] = sum(strength[0]...strength[x-1])
        // PP[x] = sum(P[0]...P[x-1])
        // Using i64 for sums to avoid overflow before modulo operations
        let mut p = vec![0i64; n + 1];
        for i in 0..n {
            p[i + 1] = p[i] + strength[i] as i64;
        }

        let mut pp = vec![0i64; n + 2];
        for i in 0..n + 1 {
            pp[i + 1] = pp[i] + p[i];
        }

        let mut total_strength_sum: i64 = 0;

        for i in 0..n {
            let s_i = strength[i] as i64;
            let l = left_smaller[i] as i64; // left_bound for start index, exclusive
            let r = right_smaller_equal[i] as i64; // right_bound for end index, exclusive

            // Subarrays start at j, end at k
            // l < j <= i <= k < r
            // So, j ranges from l+1 to i
            // And k ranges from i to r-1

            let l_idx = l + 1; // inclusive start for j
            let r_idx = r - 1; // inclusive end for k

            // Number of possible start positions for j
            let count_j = (i as i64 - l_idx + 1);
            // Number of possible end positions for k
            let count_k = (r_idx - i as i64 + 1);

            // Sum of prefix sums: sum_{x=start}^{end} P[x] = PP[end+1] - PP[start]
            // Sum of P[k+1] for k in [i, r_idx] is sum of P[x] for x in [i+1, r_idx+1]
            let sum_p_k_plus_1 = (pp[(r_idx + 2) as usize] - pp[(i + 1) as usize] + modulo) % modulo;

            // Sum of P[j] for j in [l_idx, i]
            let sum_p_j = (pp[(i + 1) as usize] - pp[l_idx as usize] + modulo) % modulo;

            let term1 = (count_j * sum_p_k_plus_1) % modulo;
            let term2 = (count_k * sum_p_j) % modulo;

            let contribution = (s_i * (term1 - term2 + modulo) % modulo) % modulo;
            total_strength_sum = (total_strength_sum + contribution) % modulo;
        }

        total_strength_sum as i32
    }
}