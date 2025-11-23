impl Solution {
    /// Helper function to calculate the merged string when `s2` is appended to `s1`
    /// with maximum overlap.
    ///
    /// This function assumes `s1` does not fully contain `s2` and `s2` does not fully contain `s1`.
    /// It finds the longest suffix of `s1` that is also a prefix of `s2`, and appends
    /// the remaining part of `s2` to `s1`.
    ///
    /// # Arguments
    /// * `s1` - The first string.
    /// * `s2` - The second string.
    ///
    /// # Returns
    /// A `String` representing `s1` combined with `s2` with maximum overlap.
    fn calculate_overlap_merge(s1: &str, s2: &str) -> String {
        let mut max_overlap = 0;
        // Iterate from max possible overlap down to 1
        for k in (1..=s1.len().min(s2.len())).rev() {
            if s1.ends_with(&s2[0..k]) {
                max_overlap = k;
                break;
            }
        }
        s1.to_string() + &s2[max_overlap..]
    }

    /// Helper function to merge two strings `s1` and `s2` into the shortest possible
    /// string that contains both, prioritizing lexicographical order for equal lengths.
    ///
    /// It handles four main scenarios:
    /// 1. `s1` already contains `s2`.
    /// 2. `s2` already contains `s1`.
    /// 3. Neither contains the other, so it calculates two candidates:
    ///    a. `s1` followed by `s2` with maximum overlap.
    ///    b. `s2` followed by `s1` with maximum overlap.
    ///    It then returns the shorter of the two, or the lexicographically smaller
    ///    if their lengths are equal.
    ///
    /// # Arguments
    /// * `s1` - The first string.
    /// * `s2` - The second string.
    ///
    /// # Returns
    /// A `String` representing the shortest and lexicographically smallest string
    /// that contains both `s1` and `s2`.
    fn merge_two_strings(s1: &str, s2: &str) -> String {
        // Case 1: s1 already contains s2
        if s1.contains(s2) {
            return s1.to_string();
        }
        // Case 2: s2 already contains s1
        if s2.contains(s1) {
            return s2.to_string();
        }

        // Case 3: No full containment, calculate overlaps for both orders
        let res_s1_s2 = Solution::calculate_overlap_merge(s1, s2);
        let res_s2_s1 = Solution::calculate_overlap_merge(s2, s1);

        // Compare results based on length, then lexicographical order
        if res_s1_s2.len() < res_s2_s1.len() {
            res_s1_s2
        } else if res_s2_s1.len() < res_s1_s2.len() {
            res_s2_s1
        } else { // Lengths are equal, choose lexicographically smaller
            if res_s1_s2 < res_s2_s1 {
                res_s1_s2
            } else {
                res_s2_s1
            }
        }
    }

    pub fn shortest_string_that_contains_three_strings(a: String, b: String, c: String) -> String {
        let strings = vec![a, b, c];
        let mut filtered_strings = Vec::new();

        // Mark strings that are fully contained within another string as redundant.
        let mut exclude = vec![false; 3];
        for i in 0..3 {
            for j in 0..3 {
                if i == j { continue; }
                if strings[i].contains(&strings[j]) {
                    exclude[j] = true;
                }
            }
        }

        // Collect only the non-redundant strings.
        for i in 0..3 {
            if !exclude[i] {
                filtered_strings.push(strings[i].clone());
            }
        }

        // Handle cases where fewer than 3 unique strings remain after filtering.
        match filtered_strings.len() {
            0 => return String::new(), // Should not happen based on constraints (non-empty strings)
            1 => return filtered_strings[0].clone(),
            2 => return Solution::merge_two_strings(&filtered_strings[0], &filtered_strings[1]),
            _ => {} // Continue with 3 strings
        }

        // Initialize min_res with a string guaranteed to be longer and lexicographically
        // larger than any possible valid result. Max length of a result is 300 (100*3).
        let mut min_res = "z".repeat(301);

        // All 3! = 6 permutations of indices (0, 1, 2)
        let permutations = vec![
            vec![0, 1, 2],
            vec![0, 2, 1],
            vec![1, 0, 2],
            vec![1, 2, 0],
            vec![2, 0, 1],
            vec![2, 1, 0],
        ];

        for perm in permutations {
            let s1 = &filtered_strings[perm[0]];
            let s2 = &filtered_strings[perm[1]];
            let s3 = &filtered_strings[perm[2]];

            // Step 1: Merge s1 and s2
            let temp = Solution::merge_two_strings(s1, s2);

            // Step 2: Merge the result of (s1, s2) with s3
            let current_res = Solution::merge_two_strings(&temp, s3);

            // Step 3: Compare current_res with min_res
            if current_res.len() < min_res.len() {
                min_res = current_res;
            } else if current_res.len() == min_res.len() {
                if current_res < min_res {
                    min_res = current_res;
                }
            }
        }

        min_res
    }
}