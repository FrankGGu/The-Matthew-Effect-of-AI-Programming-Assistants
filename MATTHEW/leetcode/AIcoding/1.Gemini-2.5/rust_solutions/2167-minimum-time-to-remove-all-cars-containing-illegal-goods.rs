impl Solution {
    pub fn minimum_time(s: String) -> i32 {
        let n = s.len();
        if n == 0 {
            return 0;
        }

        let chars: Vec<char> = s.chars().collect();

        // prefix_ones[k] stores the count of '1's in s[0..k-1]
        // prefix_ones will have length n+1, where prefix_ones[0] = 0
        let mut prefix_ones: Vec<i32> = vec![0; n + 1];
        for k in 0..n {
            prefix_ones[k + 1] = prefix_ones[k] + (if chars[k] == '1' { 1 } else { 0 });
        }

        // Initialize min_cost with the cost of removing all cars from one end.
        // For example, removing all 'N' cars from the left costs N.
        let mut min_cost = n as i32;

        // min_left_prefix_term stores the minimum value of (i - 2 * prefix_ones[i])
        // for 0 <= i <= current_j_plus_1.
        // This term represents the optimized left part of the cost function:
        // cost = i + (N - 1 - j) + 2 * (prefix_ones[j+1] - prefix_ones[i])
        //      = (i - 2 * prefix_ones[i]) + (N - 1 - j + 2 * prefix_ones[j+1])
        // The initial value corresponds to i=0: 0 - 2 * prefix_ones[0] = 0.
        let mut min_left_prefix_term = 0;

        // Iterate j from 0 to N-1.
        // 'j' represents the rightmost index of the "middle segment" s[i..j].
        // For each 'j', we want to find the best 'i' (leftmost index of the middle segment)
        // such that 0 <= i <= j+1.
        for j in 0..n {
            // Calculate the (i - 2 * prefix_ones[i]) term for i = j+1.
            // This is a candidate for min_left_prefix_term.
            let current_i_val = (j + 1) as i32 - 2 * prefix_ones[j + 1];

            // Update min_left_prefix_term to keep track of the minimum value encountered so far.
            min_left_prefix_term = min_left_prefix_term.min(current_i_val);

            // Calculate the total cost for the current 'j' using the minimum 'min_left_prefix_term'.
            // This corresponds to:
            // min_i (i + (N - 1 - j) + 2 * (prefix_ones[j+1] - prefix_ones[i]))
            let current_total_cost = min_left_prefix_term + (n - 1 - j) as i32 + 2 * prefix_ones[j + 1];

            // Update the overall minimum cost.
            min_cost = min_cost.min(current_total_cost);
        }

        min_cost
    }
}