impl Solution {
    pub fn min_bit_flips(start: i32, goal: i32) -> i32 {
        let xor = start ^ goal;
        xor.count_ones() as i32
    }
}