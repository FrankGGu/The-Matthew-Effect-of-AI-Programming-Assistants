impl Solution {
    pub fn binary_gap(n: i32) -> i32 {
        let mut n = n;
        let mut max_gap = 0;
        let mut last_one_idx = -1;
        let mut current_idx = 0;

        while n > 0 {
            if (n & 1) == 1 {
                if last_one_idx != -1 {
                    max_gap = max_gap.max(current_idx - last_one_idx);
                }
                last_one_idx = current_idx;
            }
            n >>= 1;
            current_idx += 1;
        }

        max_gap
    }
}