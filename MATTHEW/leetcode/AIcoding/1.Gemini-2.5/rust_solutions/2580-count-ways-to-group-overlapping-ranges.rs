impl Solution {
    pub fn count_ways(mut ranges: Vec<Vec<i32>>) -> i32 {
        if ranges.is_empty() {
            return 1;
        }

        ranges.sort_unstable_by_key(|r| r[0]);

        let mut num_disjoint_groups = 0;
        let mut current_end = -1; // Initialize with a value smaller than any possible range start

        for range in ranges {
            let start = range[0];
            let end = range[1];

            if start > current_end {
                // This range starts after the current merged group ends,
                // so it forms a new disjoint group.
                num_disjoint_groups += 1;
                current_end = end;
            } else {
                // This range overlaps with or is contained within the current merged group.
                // Extend the current merged group's end if necessary.
                current_end = current_end.max(end);
            }
        }

        let modulus = 1_000_000_007;
        Self::power(2, num_disjoint_groups, modulus) as i32
    }

    // Helper function for modular exponentiation (base^exp % modulus)
    fn power(mut base: i64, mut exp: i64, modulus: i64) -> i64 {
        let mut res = 1;
        base %= modulus;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % modulus;
            }
            base = (base * base) % modulus;
            exp /= 2;
        }
        res
    }
}