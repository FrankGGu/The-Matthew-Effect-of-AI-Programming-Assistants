impl Solution {
    pub fn xor_operation(n: i32, start: i32) -> i32 {
        let mut res = 0;
        for i in 0..n {
            res ^= start + 2 * i;
        }
        res
    }
}