impl Solution {
    pub fn max_envelopes(mut envelopes: Vec<Vec<i32>>) -> i32 {
        if envelopes.is_empty() {
            return 0;
        }

        envelopes.sort_unstable_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                b[1].cmp(&a[1])
            }
        });

        let mut tails = Vec::new();

        for envelope in envelopes {
            let height = envelope[1];
            match tails.binary_search(&height) {
                Ok(idx) => {
                    // If height is found, it means there's already an increasing subsequence
                    // ending with this height. We don't need to do anything, or we could
                    // potentially replace it with itself if we wanted to be explicit.
                    // For LIS, we only care about the smallest tail for a given length.
                    // If multiple elements are equal, binary_search might return any of their indices.
                    // To ensure we replace the first occurrence or maintain the property,
                    // we can just replace it.
                    tails[idx] = height;
                },
                Err(idx) => {
                    if idx == tails.len() {
                        tails.push(height);
                    } else {
                        tails[idx] = height;
                    }
                }
            }
        }

        tails.len() as i32
    }
}