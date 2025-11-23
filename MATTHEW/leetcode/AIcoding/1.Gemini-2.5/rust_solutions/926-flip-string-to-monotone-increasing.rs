impl Solution {
    pub fn min_flips_mono_incr(s: String) -> i32 {
        // cost_0: minimum flips to make the prefix s[0...i] all '0's.
        // cost_1: minimum flips to make the prefix s[0...i] monotone increasing and ending with '1'.
        // For an empty prefix (before processing any characters), both costs are 0.
        let mut cost_0 = 0;
        let mut cost_1 = 0;

        for c in s.chars() {
            let prev_cost_0 = cost_0;
            let prev_cost_1 = cost_1;

            if c == '0' {
                // If current character is '0':
                // To maintain an all '0's prefix: no flip needed for this character.
                cost_0 = prev_cost_0;
                // To maintain a monotone increasing prefix ending with '1':
                // This '0' must be flipped to '1'.
                // It can follow an all '0's prefix (prev_cost_0) or a monotone increasing prefix ending with '1' (prev_cost_1).
                // We take the minimum of these two previous states and add 1 for the current flip.
                cost_1 = std::cmp::min(prev_cost_0, prev_cost_1) + 1;
            } else { // c == '1'
                // If current character is '1':
                // To maintain an all '0's prefix: this '1' must be flipped to '0'.
                cost_0 = prev_cost_0 + 1;
                // To maintain a monotone increasing prefix ending with '1':
                // No flip needed for this character.
                // It can follow an all '0's prefix (prev_cost_0) or a monotone increasing prefix ending with '1' (prev_cost_1).
                // We take the minimum of these two previous states.
                cost_1 = std::cmp::min(prev_cost_0, prev_cost_1);
            }
        }

        // After iterating through all characters, the minimum flips for the entire string
        // will be the minimum of making it all '0's or making it monotone increasing ending with '1'.
        std::cmp::min(cost_0, cost_1) as i32
    }
}