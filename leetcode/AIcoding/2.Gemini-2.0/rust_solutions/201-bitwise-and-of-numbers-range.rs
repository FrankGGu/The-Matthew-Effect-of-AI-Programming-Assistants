impl Solution {
    pub fn range_bitwise_and(left: i32, right: i32) -> i32 {
        let mut m = left;
        let mut n = right;
        let mut shift = 0;
        while m != n {
            m >>= 1;
            n >>= 1;
            shift += 1;
        }
        m << shift
    }
}