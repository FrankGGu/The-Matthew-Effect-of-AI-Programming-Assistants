impl Solution {
    pub fn find_maximum_number_of_non_intersecting_substrings(s: String) -> i32 {
        let n = s.len();
        if n == 0 {
            return 0;
        }
        let s_bytes = s.as_bytes();

        let mut first = vec![n; 26]; // Stores first occurrence index for each char
        let mut last = vec![0; 26];  // Stores last occurrence index for each char

        for i in 0..n {
            let char_idx = (s_bytes[i] - b'a') as usize;
            first[char_idx] = first[char_idx].min(i);
            last[char_idx] = last[char_idx].max(i);
        }

        let mut candidates: Vec<(usize, usize)> = Vec::new();

        let mut i = 0;
        while i < n {
            let char_idx = (s_bytes[i] - b'a') as usize;

            // Only consider starting a new segment if 'i' is the first occurrence of s[i]
            // This ensures we find the leftmost possible start for any such segment.
            if first[char_idx] == i {
                let mut current_start = i;
                let mut current_end = last[char_idx];
                let mut valid_segment = true;

                let mut k = i;
                while k <= current_end {
                    let k_char_idx = (s_bytes[k] - b'a') as usize;
                    if first[k_char_idx] < current_start {
                        // Character s[k] starts before our current segment's start.
                        // This means s[current_start..current_end] cannot be a valid substring
                        // because it does not contain all occurrences of s[k].
                        // Discard this potential segment.
                        valid_segment = false;
                        break; // Break from inner k loop
                    }
                    current_end = current_end.max(last[k_char_idx]);
                    k += 1;
                }

                if valid_segment {
                    candidates.push((current_start, current_end));
                }
            }
            // Always increment i to check for the next potential starting point
            i += 1;
        }

        // Sort candidates by end index primarily, then by start index.
        // This greedy strategy ensures we pick the earliest ending substring
        // to leave maximum space for subsequent substrings.
        candidates.sort_unstable_by_key(|&(start, end)| (end, start));

        let mut count = 0;
        let mut prev_end = -1; // Use -1 to indicate no previous substring has been selected

        for &(start, end) in candidates.iter() {
            if start as i32 > prev_end {
                // If the current substring starts after the previous selected substring ends,
                // it is non-overlapping. Select it.
                count += 1;
                prev_end = end as i32;
            }
        }

        count
    }
}