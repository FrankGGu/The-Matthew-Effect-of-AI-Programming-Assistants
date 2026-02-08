impl Solution {
    pub fn shortest_superstring(words: Vec<String>) -> String {
        let n = words.len();

        // Precompute overlaps: overlaps[i][j] stores the maximum overlap when words[j] follows words[i].
        let mut overlaps = vec![vec![0; n]; n];
        for i in 0..n {
            for j in 0..n {
                if i == j {
                    continue;
                }
                overlaps[i][j] = calculate_overlap(&words[i], &words[j]);
            }
        }

        // dp[mask][i] stores the maximum total overlap when the strings in 'mask'
        // have been used, and words[i] is the last string in the sequence.
        // Initialize with a very small number to represent unreachable states.
        let mut dp = vec![vec![i32::MIN / 2; n]; 1 << n];

        // parent[mask][i] stores the index of the string that came before words[i]
        // in the optimal path for dp[mask][i].
        let mut parent = vec![vec![0; n]; 1 << n]; // Initialized with 0, will be overwritten for reachable states.

        // Initialize base cases: a path with just one string has 0 internal overlap.
        for i in 0..n {
            dp[1 << i][i] = 0;
        }

        // Iterate through all masks (subsets of strings)
        for mask in 1..(1 << n) {
            // Iterate through all possible last strings 'i' for the current mask
            for i in 0..n {
                if (mask >> i) & 1 == 1 { // If words[i] is in the current mask
                    let prev_mask = mask ^ (1 << i); // Mask without words[i]

                    // If prev_mask is 0, it means words[i] is the first string.
                    // Its dp value is already initialized to 0, so we skip further processing for this base case.
                    if prev_mask == 0 {
                        continue;
                    }

                    // Try to find a previous string 'j' that was in prev_mask
                    for j in 0..n {
                        if (prev_mask >> j) & 1 == 1 { // If words[j] was in prev_mask
                            // Ensure the previous state was reachable
                            if dp[prev_mask][j] != i32::MIN / 2 {
                                let current_overlap = dp[prev_mask][j] + overlaps[j][i] as i32;
                                if current_overlap > dp[mask][i] {
                                    dp[mask][i] = current_overlap;
                                    parent[mask][i] = j;
                                }
                            }
                        }
                    }
                }
            }
        }

        // Find the maximum overlap and the last string in the optimal path
        let mut max_overlap = i32::MIN / 2;
        let mut last_idx = 0;
        let final_mask = (1 << n) - 1;
        for i in 0..n {
            if dp[final_mask][i] > max_overlap {
                max_overlap = dp[final_mask][i];
                last_idx = i;
            }
        }

        // Reconstruct the path (sequence of string indices)
        let mut path_indices: Vec<usize> = Vec::with_capacity(n);
        let mut current_mask = final_mask;
        let mut current_node = last_idx;

        // We know there are N strings in the path, so we iterate N times.
        for _ in 0..n {
            path_indices.push(current_node);
            let prev_node = parent[current_mask][current_node];
            current_mask ^= (1 << current_node); // Remove current_node from mask
            current_node = prev_node;
        }
        path_indices.reverse(); // Now the path is in the correct order

        // Construct the shortest superstring
        let mut result = words[path_indices[0]].clone();
        for k in 1..n {
            let prev_word_idx = path_indices[k - 1];
            let current_word_idx = path_indices[k];
            let overlap_val = overlaps[prev_word_idx][current_word_idx];
            result.push_str(&words[current_word_idx][overlap_val..]);
        }

        result
    }
}

fn calculate_overlap(s1: &str, s2: &str) -> usize {
    let n1 = s1.len();
    let n2 = s2.len();
    let mut max_overlap = 0;
    for k in 1..=std::cmp::min(n1, n2) {
        // Check if s1's suffix of length k matches s2's prefix of length k
        if s1[n1 - k..] == s2[..k] {
            max_overlap = k;
        }
    }
    max_overlap
}