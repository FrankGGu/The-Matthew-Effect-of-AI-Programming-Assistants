impl Solution {
    pub fn has_alternating_bits(n: i32) -> bool {
        let mut prev = -1;
        let mut num = n;
        while num > 0 {
            let curr = num % 2;
            if curr == prev {
                return false;
            }
            prev = curr;
            num /= 2;
        }
        true
    }
}