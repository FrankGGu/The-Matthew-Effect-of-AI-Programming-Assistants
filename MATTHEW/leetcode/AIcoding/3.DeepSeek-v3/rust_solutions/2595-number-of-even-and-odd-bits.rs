impl Solution {
    pub fn even_odd_bit(n: i32) -> Vec<i32> {
        let mut even = 0;
        let mut odd = 0;
        let mut num = n;
        for i in 0..32 {
            if num & (1 << i) != 0 {
                if i % 2 == 0 {
                    even += 1;
                } else {
                    odd += 1;
                }
            }
        }
        vec![even, odd]
    }
}