impl Solution {
    pub fn num_of_ways(s: String) -> i64 {
        let n = s.len();
        let mut total_ones: i64 = 0;
        for c in s.chars() {
            if c == '1' {
                total_ones += 1;
            }
        }

        if total_ones % 3 != 0 {
            return 0;
        }

        if total_ones == 0 {
            // If the string contains only zeros, we need to split it into three non-empty parts.
            // This is equivalent to choosing two distinct cut points from n-1 possible positions.
            // The number of ways to choose 2 points from n-1 is C(n-1, 2) = (n-1) * (n-2) / 2.
            // Since n >= 3, n-1 >= 2 and n-2 >= 1, so this is always valid.
            let n_i64 = n as i64;
            return (n_i64 - 1) * (n_i64 - 2) / 2;
        }

        // If total_ones > 0 and is divisible by 3
        let target_ones_per_part = total_ones / 3;

        let mut ones_indices: Vec<usize> = Vec::new();
        for (i, c) in s.chars().enumerate() {
            if c == '1' {
                ones_indices.push(i);
            }
        }

        // The first cut separates the first part (with `target_ones_per_part` ones)
        // from the rest of the string.
        // The first part must end after the (target_ones_per_part - 1)-th '1' (0-indexed).
        // It must end before the target_ones_per_part-th '1' (0-indexed) begins.
        // The number of positions for the first cut is the difference between the index
        // of the target_ones_per_part-th '1' and the (target_ones_per_part - 1)-th '1'.
        let first_cut_choices = (ones_indices[target_ones_per_part as usize] - ones_indices[target_ones_per_part as usize - 1]) as i64;

        // The second cut separates the second part (also with `target_ones_per_part` ones)
        // from the third part.
        // The second part must end after the (2 * target_ones_per_part - 1)-th '1'.
        // It must end before the (2 * target_ones_per_part)-th '1' begins.
        // The number of positions for the second cut is the difference between the index
        // of the (2 * target_ones_per_part)-th '1' and the (2 * target_ones_per_part - 1)-th '1'.
        let second_cut_choices = (ones_indices[(2 * target_ones_per_part) as usize] - ones_indices[(2 * target_ones_per_part) as usize - 1]) as i64;

        first_cut_choices * second_cut_choices
    }
}