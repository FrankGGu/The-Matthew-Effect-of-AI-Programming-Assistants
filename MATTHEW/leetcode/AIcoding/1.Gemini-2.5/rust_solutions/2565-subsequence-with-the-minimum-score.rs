impl Solution {
    pub fn minimum_score(s: String, target: String) -> i32 {
        let n = s.len();
        let m = target.len();
        let s_bytes = s.as_bytes();
        let t_bytes = target.as_bytes();

        // left_indices[i] stores the smallest index in s where target[i] is matched,
        // assuming target[0...i-1] were matched as early as possible.
        // This effectively gives the indices for the earliest possible prefix match.
        let mut left_indices = vec![0; m];
        let mut s_ptr = 0;
        for t_ptr in 0..m {
            while s_ptr < n && s_bytes[s_ptr] != t_bytes[t_ptr] {
                s_ptr += 1;
            }
            left_indices[t_ptr] = s_ptr;
            s_ptr += 1;
        }

        // right_indices[i] stores the largest index in s where target[i] is matched,
        // assuming target[i+1...m-1] were matched as late as possible.
        // This effectively gives the indices for the latest possible suffix match.
        let mut right_indices = vec![0; m];
        s_ptr = n - 1;
        for t_ptr in (0..m).rev() {
            while s_ptr >= 0 && s_bytes[s_ptr] != t_bytes[t_ptr] {
                s_ptr -= 1;
            }
            right_indices[t_ptr] = s_ptr;
            s_ptr -= 1;
        }

        // Binary search for the minimum possible score (length of the segment in s).
        // The score can range from m (if s == target) to n (if target is a very sparse subsequence).
        let mut low = m as i32;
        let mut high = n as i32;
        let mut ans = n as i32;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::check(mid, m, n, &left_indices, &right_indices) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        ans
    }

    // Checks if it's possible to form 'target' as a subsequence of 's'
    // such that the score (max_s_idx - min_s_idx + 1) is at most 'k'.
    fn check(
        k: i32,
        m: usize,
        n: usize,
        left_indices: &[usize],
        right_indices: &[usize],
    ) -> bool {
        // Case 1: Entire target matched by a prefix of s.
        // The subsequence uses left_indices[0] as p_0 and left_indices[m-1] as p_{m-1}.
        if (left_indices[m - 1] - left_indices[0] + 1) as i32 <= k {
            return true;
        }

        // Case 2: Entire target matched by a suffix of s.
        // The subsequence uses right_indices[0] as p_0 and right_indices[m-1] as p_{m-1}.
        if (right_indices[m - 1] - right_indices[0] + 1) as i32 <= k {
            return true;
        }

        // Case 3: Target is split into a prefix target[0...i-1] and a suffix target[i...m-1].
        // The prefix target[0...i-1] is matched using left_indices.
        // The suffix target[i...m-1] is matched using right_indices.
        // We iterate 'i' from 0 to m (length of the prefix matched by left_indices).
        // 'i' represents the length of the prefix of target that is matched using `left_indices`.
        // So `target[0...i-1]` is matched.
        // The overall `p_0` will be `left_indices[0]`.
        // The overall `p_{m-1}` will be `right_indices[m-1]`.
        // We need to find `j` such that `j >= i` and `right_indices[j]` is the start of the suffix match
        // and `right_indices[j] > left_indices[i-1]` (if `i > 0`).
        // And `right_indices[m-1] - left_indices[0] + 1 <= k`.
        // This specific formulation is incorrect.

        // The correct check for a given `k` is to iterate over all possible prefix lengths `i` (from 0 to m)
        // matched by `left_indices`, and then find a suffix matched by `right_indices` that fits.
        // `i` here is the *index* of the last character of the prefix matched by `left_indices`.
        // So `target[0...i]` is matched by `left_indices[0...i]`.
        // `p_0` for this prefix is `left_indices[0]`.
        // `p_i` for this prefix is `left_indices[i]`.
        // We need to match `target[i+1...m-1]` using `p_{i+1}, ..., p_{m-1}` such that `p_{i+1} > left_indices[i]`.
        // And the total length `p_{m-1} - p_0 + 1 <= k`.
        // This means `p_{m-1} <= p_0 + k - 1`.

        // Optimized `check(k)` using two pointers for `j` (suffix_start_t_idx)
        let mut j_ptr = m as isize - 1; // Current index in `right_indices` for the suffix start
        for i in 0..=m { // `i` is the length of the prefix of target matched by `left_indices`
            let prefix_end_s_idx = if i > 0 {
                left_indices[i - 1] as isize
            } else {
                -1
            };

            // Find the smallest `j` such that `right_indices[j] > prefix_end_s_idx` and `j >= i`.
            // We are looking for `target[j...m-1]` to be matched.
            // `j_ptr` is the index in `right_indices` corresponding to `target[j_ptr]`.
            // We want `right_indices[j_ptr]` to be the start of the suffix match.
            // So we need `right_indices[j_ptr] > prefix_end_s_idx`.
            // And `j_ptr` must be at least `i`.
            while j_ptr >= i as isize && right_indices[j_ptr as usize] as isize <= prefix_end_s_idx {
                j_ptr -= 1;
            }
            // After the loop, `j_ptr` is either -1 or `right_indices[j_ptr]` is the largest value <= `prefix_end_s_idx`.
            // We need the *smallest* `j` such that `right_indices[j] > prefix_end_s_idx`.
            // So `j_ptr + 1` is the candidate for `j`.
            let suffix_start_t_idx = j_ptr + 1;

            if suffix_start_t_idx <= m as isize - 1 { // A valid suffix part exists
                let current_p_0 = if i == 0 {
                    right_indices[suffix_start_t_idx as usize]
                } else {
                    left_indices[0]
                };
                let current_p_m_minus_1 = right_indices[m - 1];
                if (current_p_m_minus_1 - current_p_0 + 1) as i32 <= k {
                    return true;
                }
            } else if i == m { // Entire target matched by prefix (suffix_start_t_idx == m)
                // This case is already covered by the initial check for `left_indices`.
                // But if we didn't do that, it would be:
                // if (left_indices[m-1] - left_indices[0] + 1) as i32 <= k { return true; }
            }
        }

        false
    }
}