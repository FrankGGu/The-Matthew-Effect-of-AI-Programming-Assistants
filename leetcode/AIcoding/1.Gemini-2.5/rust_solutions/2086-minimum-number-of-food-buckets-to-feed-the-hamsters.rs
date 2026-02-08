impl Solution {
    pub fn minimum_buckets(hamsters: String) -> i32 {
        let n = hamsters.len();
        let mut s_chars: Vec<char> = hamsters.chars().collect();
        let mut buckets_count = 0;
        let mut i = 0;

        while i < n {
            if s_chars[i] == '.' {
                i += 1;
                continue;
            }

            // s_chars[i] is 'H'
            // Check if it's already fed by a bucket at i-1
            if i > 0 && s_chars[i-1] == 'B' {
                i += 1;
                continue;
            }

            // If not fed by i-1, we must place a bucket.
            // Try to place a bucket at i+1 (right side) to cover s_chars[i] and potentially s_chars[i+2].
            if i + 1 < n && s_chars[i+1] == '.' {
                s_chars[i+1] = 'B'; // Mark as bucket placed
                buckets_count += 1;
                // This bucket at i+1 feeds s_chars[i] and s_chars[i+2].
                // So, we can skip i+1 (which is now a bucket) and i+2 (which is now fed).
                // The next iteration should start checking from i+3.
                i += 3;
            }
            // Else, try to place a bucket at i-1 (left side) to cover s_chars[i].
            else if i > 0 && s_chars[i-1] == '.' {
                s_chars[i-1] = 'B'; // Mark as bucket placed
                buckets_count += 1;
                // This bucket at i-1 feeds s_chars[i-2] and s_chars[i].
                // We just move to the next character, s_chars[i] is fed.
                i += 1;
            }
            // Cannot place a bucket to feed this 'H'.
            else {
                return -1;
            }
        }

        buckets_count
    }
}