use std::collections::HashMap;

impl Solution {
    pub fn substring_xor_queries(s: String, queries: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        // MAX_BITS is chosen to cover the maximum possible target value.
        // xor_val < 10^9, which is less than 2^30.
        // If val is 2^30 - 1 and xor_val is 2^30, target_val = (2^30 - 1) ^ 2^30 = 2^31 - 1.
        // So, target_val can be up to 2^31 - 1, which requires 31 bits.
        const MAX_BITS: u32 = 31; 

        let s_bytes = s.as_bytes();
        let n = s.len();

        // Map to store (value, (start_index, end_index)) for all relevant substrings.
        // We want the smallest start_index, then smallest end_index.
        // Iterating i from 0 to n-1, then j from i to n-1 naturally finds occurrences
        // in increasing order of (start_index, end_index).
        // `or_insert` ensures that for each value, only its first occurrence (smallest i, then smallest j) is stored.
        let mut val_to_indices: HashMap<u32, (i32, i32)> = HashMap::new();

        for i in 0..n {
            let mut current_val: u32 = 0;
            for j in i..n {
                let digit = (s_bytes[j] - b'0') as u32;

                // Check if `current_val` is already too large (>= 2^MAX_BITS)
                // or if multiplying by 2 and adding `digit` would make it too large or overflow u32.
                // If `current_val` is already `2^MAX_BITS` or more, any further extension will also be too large.
                // Values >= 2^MAX_BITS are not stored in the map.
                if current_val >= (1u32 << MAX_BITS) {
                    break; 
                }

                // Check if `current_val * 2 + digit` would overflow u32.
                // `u32::MAX / 2` is `2^31 - 1`. If `current_val` is `2^31 - 1` and `digit` is `1`,
                // `current_val * 2 + 1` would be `2^32 - 1`. This fits in u32.
                // But if `current_val` is `2^31` and `digit` is `1`, `current_val * 2 + 1` would be `2^32 + 1`, which overflows u32.
                // The actual check for overflow is `current_val > u32::MAX / 2` or (`current_val == u32::MAX / 2` and `digit == 1`).
                // If it overflows u32, it's definitely >= 2^MAX_BITS.
                if current_val > (u32::MAX / 2) || (current_val == (u32::MAX / 2) && digit == 1) {
                    break;
                }

                current_val = current_val * 2 + digit;

                // If the new `current_val` is >= 2^MAX_BITS, it's too large for our map.
                if current_val >= (1u32 << MAX_BITS) {
                    break;
                }

                val_to_indices.entry(current_val).or_insert((i as i32, j as i32));
            }
        }

        let mut results: Vec<Vec<i32>> = Vec::with_capacity(queries.len());

        for query in queries {
            let first_i = query[0] as usize;
            let second_i = query[1] as usize;
            let xor_val = query[2] as u32;

            // Calculate `val` from `s[first_i...second_i]`.
            // Use u64 for intermediate calculation to detect overflow beyond u32::MAX.
            let mut temp_query_val: u64 = 0;

            for k in first_i..=second_i {
                let digit = (s_bytes[k] - b'0') as u64;

                // Check for overflow before multiplication.
                // If `temp_query_val` is already so large that multiplying by 2 would overflow u64,
                // then cap it to a value that signifies "too large" and break.
                if temp_query_val > (u64::MAX / 2) || (temp_query_val == (u64::MAX / 2) && digit == 1) {
                    temp_query_val = (1u64 << MAX_BITS) + 1; // Sentinel value for "too large for u32"
                    break; 
                }
                temp_query_val = temp_query_val * 2 + digit;
            }

            // Convert `temp_query_val` to `u32`. If it exceeds `u32::MAX`, use a sentinel.
            let query_val: u32 = if temp_query_val > u32::MAX as u64 {
                1u32 << MAX_BITS // Sentinel value (2^31) for "value too large for u32"
            } else {
                temp_query_val as u32
            };

            let target_val = query_val ^ xor_val;

            // If `target_val` is >= 2^MAX_BITS, it means it's outside the range of values
            // stored in our `val_to_indices` map (which only contains values < 2^MAX_BITS).
            if target_val >= (1u32 << MAX_BITS) {
                results.push(vec![-1, -1]);
            } else {
                results.push(
                    val_to_indices
                        .get(&target_val)
                        .map_or(vec![-1, -1], |&(i, j)| vec![i, j]),
                );
            }
        }

        results
    }
}