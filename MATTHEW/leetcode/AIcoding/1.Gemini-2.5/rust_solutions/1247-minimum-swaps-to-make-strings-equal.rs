impl Solution {
    pub fn minimum_swaps(s1: String, s2: String) -> i32 {
        let mut count_xy = 0; // Number of positions where s1[i] = 'x' and s2[i] = 'y'
        let mut count_yx = 0; // Number of positions where s1[i] = 'y' and s2[i] = 'x'

        // Iterate over characters of both strings simultaneously to count mismatches
        for (c1, c2) in s1.chars().zip(s2.chars()) {
            if c1 != c2 {
                if c1 == 'x' {
                    count_xy += 1;
                } else { // c1 == 'y'
                    count_yx += 1;
                }
            }
        }

        // If the total number of mismatches (count_xy + count_yx) is odd,
        // it's impossible to make the strings equal. This is because each swap
        // involves two characters, preserving the parity of 'x' and 'y' counts.
        // For s1 and s2 to be equal, the total count of 'x's across both strings
        // must be even, and similarly for 'y's. This implies (count_xy + count_yx)
        // must be even, meaning count_xy and count_yx must have the same parity.
        if (count_xy + count_yx) % 2 != 0 {
            return -1;
        }

        let mut swaps = 0;

        // Each pair of 'xy' mismatches can be resolved in 1 swap.
        // Example: s1 = "xx", s2 = "yy". Mismatches at 0 and 1 are (x,y), (x,y).
        // Swap s1[0] and s2[1]. s1 becomes "yx", s2 becomes "yx". 1 swap.
        swaps += count_xy / 2;

        // Each pair of 'yx' mismatches can be resolved in 1 swap.
        // Example: s1 = "yy", s2 = "xx". Mismatches at 0 and 1 are (y,x), (y,x).
        // Swap s1[0] and s2[1]. s1 becomes "xy", s2 becomes "xy". 1 swap.
        swaps += count_yx / 2;

        // If after resolving pairs, there's one 'xy' mismatch and one 'yx' mismatch left
        // (i.e., both count_xy and count_yx were odd), they require 2 additional swaps.
        // Example: s1 = "xy", s2 = "yx". Mismatches are (x,y) at 0 and (y,x) at 1.
        // 1. Swap s1[0] and s2[0]: s1 becomes "yy", s2 becomes "xx".
        //    Now we have two (y,x) mismatches at 0 and 1.
        // 2. Swap s1[0] and s2[1]: s1 becomes "xy", s2 becomes "xy".
        // Total 2 swaps.
        if count_xy % 2 == 1 { // This implies count_yx % 2 == 1 due to the parity check above
            swaps += 2;
        }

        swaps
    }
}