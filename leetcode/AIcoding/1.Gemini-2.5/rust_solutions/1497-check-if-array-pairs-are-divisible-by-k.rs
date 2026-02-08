impl Solution {
    pub fn can_arrange(arr: Vec<i32>, k: i32) -> bool {
        let mut freq = vec![0; k as usize];

        for &num in &arr {
            // Calculate remainder ensuring it's non-negative.
            // (num % k + k) % k handles negative numbers correctly in Rust.
            let remainder = (num % k + k) % k;
            freq[remainder as usize] += 1;
        }

        // For elements with remainder 0, they must pair with other elements
        // with remainder 0. So, their count must be even.
        if freq[0] % 2 != 0 {
            return false;
        }

        // For other remainders i, they must pair with elements with remainder k - i.
        // So, their counts must be equal.
        // We only need to iterate up to k/2 because (k - i) will be covered.
        for i in 1..=(k / 2) {
            if i == k - i {
                // This case happens when k is even and i is k/2.
                // Elements with remainder k/2 must pair with other elements with remainder k/2.
                // So, their count must be even.
                if freq[i as usize] % 2 != 0 {
                    return false;
                }
            } else {
                // For all other pairs (i, k-i), their counts must be equal.
                if freq[i as usize] != freq[(k - i) as usize] {
                    return false;
                }
            }
        }

        true
    }
}