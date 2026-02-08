impl Solution {
    pub fn smallest_repunit_div_by_k(k: i32) -> i32 {
        if k % 2 == 0 || k % 5 == 0 {
            return -1;
        }
        let mut remainder = 1;
        let mut length = 1;
        while remainder % k != 0 {
            remainder = (remainder * 10 + 1) % k;
            length += 1;
        }
        length
    }
}