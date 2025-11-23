impl Solution {
    pub fn construct_minimum_bitwise_array(n: i32) -> i32 {
        let i = n - 1;
        i ^ (i / 2)
    }
}