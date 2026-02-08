use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn moves_to_stamp(stamp: String, target: String) -> Vec<i32> {
        let s_chars: Vec<char> = stamp.chars().collect();
        let t_chars_orig: Vec<char> = target.chars().collect();
        let n = t_chars_orig.len();
        let m = s_chars.len();

        let mut t_chars: Vec<char> = t_chars_orig.clone();
        let mut result: Vec<i32> = Vec::new();
        let mut stamped_count = 0;

        // `windows[i]` stores two sets for the window `t_chars[i..i+m]`:
        // `windows[i].0`: indices `j` (relative to `i`) where `t_chars[i+j]` matches `s_chars[j]` AND `t_chars[i+j]` is not '?'.
        // `windows[i].1`: indices `j` where `t_chars[i+j]` does NOT match `s_chars[j]` AND `t_chars[i+j]` is not '?'.
        let mut windows: Vec<(HashSet<usize>, HashSet<usize>)> = Vec::with_capacity(n - m + 1);

        let mut queue: VecDeque<usize> = VecDeque::new();
        let mut visited: Vec<bool> = vec![false; n - m + 1];

        // Pre-processing and initial queue population
        for i in 0..=(n - m) {
            let mut current_matches = HashSet::new();
            let mut current_mismatches = HashSet::new();

            for j in 0..m {
                if t_chars[i + j] == s_chars[j] {
                    current_matches.insert(j);
                } else if t_chars[i + j] != '?' { 
                    current_mismatches.insert(j);
                }
            }

            // A stamp `i` is initially valid if there are no mismatches
            // AND there's at least one non-'?' character that matches (i.e., not all '?'s).
            if current_mismatches.is_empty() && !current_matches.is_empty() {
                queue.push_back(i);
                visited[i] = true;
                result.push(i as i32);
            }
            windows.push((current_matches, current_mismatches));
        }

        while let Some(curr_idx) = queue.pop_front() {
            // All characters that were non-'?' matches for `curr_idx` are now being turned into '?'.
            // `windows[curr_idx].0` contains these relative indices `j`.
            // We use `drain()` to get the elements and clear the set for `curr_idx`.
            let indices_to_stamp: Vec<usize> = windows[curr_idx].0.drain().collect();

            for j in indices_to_stamp {
                let char_pos = curr_idx + j;
                if t_chars[char_pos] != '?' { // Only update if not already '?'
                    t_chars[char_pos] = '?';
                    stamped_count += 1;

                    // If all characters are stamped, we are done.
                    if stamped_count == n {
                        break; 
                    }

                    // Check all overlapping stamps `k`
                    // `k` ranges from `max(0, char_pos - m + 1)` to `min(n - m, char_pos)`
                    let start_k = char_pos.saturating_sub(m - 1);
                    let end_k = char_pos;

                    for k in start_k..=end_k {
                        if k > n - m { continue; } // Ensure k is a valid start index for stamp

                        if !visited[k] {
                            let rel_j = char_pos - k; // Relative index within stamp `k`

                            // This character `t_chars[char_pos]` (which is now '?')
                            // was either a match or a mismatch for stamp `k`.
                            // Remove `rel_j` from `windows[k].0` (matches) or `windows[k].1` (mismatches).
                            if windows[k].0.remove(&rel_j) {
                                // Was a match, now a wildcard.
                                // If `windows[k].1` (mismatches) is empty and `windows[k].0` (matches) is not empty,
                                // then `k` becomes a valid stamp.
                                if windows[k].1.is_empty() && !windows[k].0.is_empty() {
                                    queue.push_back(k);
                                    visited[k] = true;
                                    result.push(k as i32);
                                }
                            } else if windows[k].1.remove(&rel_j) {
                                // Was a mismatch, now a wildcard.
                                // If `windows[k].1` (mismatches) is empty and `windows[k].0` (matches) is not empty,
                                // then `k` becomes a valid stamp.
                                if windows[k].1.is_empty() && !windows[k].0.is_empty() {
                                    queue.push_back(k);
                                    visited[k] = true;
                                    result.push(k as i32);
                                }
                            }
                        }
                    }
                }
            }
            // If stamped_count became n in the inner loop, we need to break from outer loop too.
            if stamped_count == n {
                break;
            }
        }

        if stamped_count == n {
            result.reverse();
            result
        } else {
            vec![]
        }
    }
}