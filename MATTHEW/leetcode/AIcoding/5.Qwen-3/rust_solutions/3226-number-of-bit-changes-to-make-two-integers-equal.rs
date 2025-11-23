struct Solution {}

impl Solution {
    pub fn min_xor_changes(a: i32, b: i32) -> i32 {
        let xor = a ^ b;
        xor.count_ones() as i32
    }
}