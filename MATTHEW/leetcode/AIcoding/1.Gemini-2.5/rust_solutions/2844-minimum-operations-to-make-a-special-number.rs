use std::cmp::min;

impl Solution {
    pub fn minimum_operations(num: String) -> i32 {
        let n = num.len();
        let chars: Vec<char> = num.chars().collect();
        let mut min_deletions = n; // Initialize with deleting all digits

        // A number is special if it is divisible by 25.
        // This means it must end in "00", "25", "50", or "75".
        // We look for the rightmost occurrence of the second digit (d2_target)
        // and then the rightmost occurrence of the first digit (d1_target)
        // before the d2_target.
        let suffixes = [
            ('0', '0'), // for "00"
            ('5', '2'), // for "25"
            ('0', '5'), // for "50"
            ('5', '7'), // for "75"
        ];

        for &(d2_target, d1_target) in suffixes.iter() {
            let mut found_d2_idx: Option<usize> = None;
            let mut found_d1_idx: Option<usize> = None;

            // Iterate from right to left to find d2 and then d1
            for i in (0..n).rev() {
                let current_char = chars[i];
                if found_d2_idx.is_none() {
                    // First, find the rightmost d2
                    if current_char == d2_target {
                        found_d2_idx = Some(i);
                    }
                } else {
                    // d2 has been found, now find the rightmost d1 before d2's position
                    if current_char == d1_target {
                        found_d1_idx = Some(i);
                        break; // Both digits found, no need to search further for this suffix
                    }
                }
            }

            if let (Some(idx1), Some(idx2)) = (found_d1_idx, found_d2_idx) {
                // Calculate the number of deletions for this suffix:
                // 1. Digits after idx2: (n - 1) - idx2
                // 2. Digits between idx1 and idx2: (idx2 - 1) - idx1
                let deletions = (n - 1 - idx2) + (idx2 - 1 - idx1);
                min_deletions = min(min_deletions, deletions);
            }
        }

        // Special case: The number "0" is divisible by 25.
        // If the original number contains at least one '0', we can delete all other digits
        // to form the number "0". This requires `n - 1` operations.
        let mut has_zero = false;
        for &c in chars.iter() {
            if c == '0' {
                has_zero = true;
                break;
            }
        }

        if has_zero {
            min_deletions = min(min_deletions, n - 1);
        }

        min_deletions as i32
    }
}