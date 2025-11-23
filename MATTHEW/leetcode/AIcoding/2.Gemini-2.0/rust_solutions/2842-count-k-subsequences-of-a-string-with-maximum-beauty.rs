impl Solution {
    pub fn count_k_subsequences_with_max_beauty(s: String, k: i32) -> i32 {
        let mut counts = [0; 26];
        for &b in s.as_bytes() {
            counts[(b - b'a') as usize] += 1;
        }
        counts.sort_unstable_by(|a, b| b.cmp(a));
        let mut distinct_chars = 0;
        for &count in &counts {
            if count > 0 {
                distinct_chars += 1;
            } else {
                break;
            }
        }

        if k > distinct_chars {
            return 0;
        }

        let target_count = counts[(k - 1) as usize];
        let mut chars_with_target_count = 0;
        let mut total_chars_with_target_count = 0;

        for &count in &counts {
            if count == target_count {
                total_chars_with_target_count += 1;
                if total_chars_with_target_count <= k {
                    chars_with_target_count += 1;
                }
            }
        }

        let mut n = total_chars_with_target_count as i64;
        let mut r = chars_with_target_count as i64;
        let mod_val = 1_000_000_007;
        let mut result = 1;

        for i in 0..r {
            result = (result * (n - i)) % mod_val;
            let mut denominator = (i + 1) % mod_val;
            let mut power = mod_val - 2;
            let mut inverse = 1;
            while power > 0 {
                if power % 2 == 1 {
                    inverse = (inverse * denominator) % mod_val;
                }
                denominator = (denominator * denominator) % mod_val;
                power /= 2;
            }
            result = (result * inverse) % mod_val;
        }

        let mut beauty = 1;
        for i in 0..k {
            beauty = (beauty * (counts[i as usize] as i64)) % mod_val;
        }

        ((result * beauty) % mod_val) as i32
    }
}