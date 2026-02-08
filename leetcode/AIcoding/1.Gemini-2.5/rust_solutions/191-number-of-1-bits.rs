impl Solution {
    pub fn hamming_weight(n: u33) -> i32 {
        n.count_ones() as i32
    }
}