impl Solution {
    pub fn binary_gap(n: i32) -> i32 {
        let mut last_index = -1;
        let mut max_gap = 0;
        let mut index = 0;

        while n > 0 {
            if n & 1 == 1 {
                if last_index != -1 {
                    max_gap = max_gap.max(index - last_index);
                }
                last_index = index;
            }
            n >>= 1;
            index += 1;
        }
        max_gap
    }
}