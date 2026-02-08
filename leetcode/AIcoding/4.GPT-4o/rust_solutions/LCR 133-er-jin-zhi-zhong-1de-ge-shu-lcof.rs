impl Solution {
    pub fn hamming_weight(n: u32) -> i32 {
        let mut count = 0;
        let mut num = n;
        while num > 0 {
            count += num & 1;
            num >>= 1;
        }
        count
    }
}