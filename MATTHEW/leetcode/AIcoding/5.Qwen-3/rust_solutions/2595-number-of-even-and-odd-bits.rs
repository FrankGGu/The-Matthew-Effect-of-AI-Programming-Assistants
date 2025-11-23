struct Solution {}

impl Solution {
    pub fn even_odd_bits(mut n: i32) -> Vec<i32> {
        let mut even = 0;
        let mut odd = 0;
        let mut position = 0;

        while n > 0 {
            if position % 2 == 0 {
                even += n & 1;
            } else {
                odd += n & 1;
            }
            n >>= 1;
            position += 1;
        }

        vec![even, odd]
    }
}