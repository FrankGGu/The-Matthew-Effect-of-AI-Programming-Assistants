impl Solution {
    pub fn even_odd_bit(n: i32) -> Vec<i32> {
        let mut even_count = 0;
        let mut odd_count = 0;
        let mut num = n;
        let mut index = 0;

        while num > 0 {
            if (num & 1) == 1 {
                if index % 2 == 0 {
                    even_count += 1;
                } else {
                    odd_count += 1;
                }
            }
            num >>= 1;
            index += 1;
        }

        vec![even_count, odd_count]
    }
}