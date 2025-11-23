impl Solution {
    pub fn binary_gap(n: i32) -> i32 {
        let mut max_gap = 0;
        let mut last = None;
        for i in 0..32 {
            if (n >> i) & 1 == 1 {
                if let Some(pos) = last {
                    max_gap = max_gap.max(i - pos);
                }
                last = Some(i);
            }
        }
        max_gap
    }
}