impl Solution {
    pub fn h_index(citations: Vec<i32>) -> i32 {
        let n = citations.len();
        if n == 0 {
            return 0;
        }

        let mut low = 0;
        let mut high = n as i32 - 1;
        let mut ans_h_index = 0;

        while low <= high {
            let mid_idx = low + (high - low) / 2;
            let h_candidate = n as i32 - mid_idx; // Number of papers from mid_idx to n-1

            if citations[mid_idx as usize] >= h_candidate {
                // This h_candidate is a possible H-index.
                // We try to find a larger one by looking at smaller indices (which means larger h_candidate).
                ans_h_index = h_candidate;
                high = mid_idx - 1;
            } else {
                // citations[mid_idx] is too small for h_candidate to be the H-index.
                // We need a smaller h_candidate, which means looking at larger indices.
                low = mid_idx + 1;
            }
        }

        ans_h_index
    }
}