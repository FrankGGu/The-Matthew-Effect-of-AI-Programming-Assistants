impl Solution {
    pub fn xor_operation(n: i32, start: i32) -> i32 {
        (0..n).map(|i| start + 2 * i).fold(0, |acc, x| acc ^ x)
    }
}