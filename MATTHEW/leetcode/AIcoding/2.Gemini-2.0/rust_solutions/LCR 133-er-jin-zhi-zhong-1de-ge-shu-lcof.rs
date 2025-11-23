impl Solution {
    pub fn hamming_weight(n: u32) -> i32 {
        let mut count = 0;
        let mut num = n;
        while num > 0 {
            num &= (num - 1);
            count += 1;
        }
        count
    }
}