struct Solution;

impl Solution {
    pub fn reinitialize_permutation(n: i32) -> i32 {
        if n == 2 {
            return 1;
        }

        let mut ops = 0;
        let mut current_pos = 1;

        loop {
            current_pos = (2 * current_pos) % (n - 1);
            ops += 1;

            if current_pos == 1 {
                break;
            }
        }

        ops
    }
}