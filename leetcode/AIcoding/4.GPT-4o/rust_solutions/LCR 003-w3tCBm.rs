impl Solution {
    pub fn count_bits(n: i32) -> Vec<i32> {
        (0..=n).map(|x| x.count_ones() as i32).collect()
    }
}