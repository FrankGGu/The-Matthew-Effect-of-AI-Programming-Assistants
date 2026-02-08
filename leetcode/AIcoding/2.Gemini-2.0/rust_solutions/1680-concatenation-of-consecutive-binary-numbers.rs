impl Solution {
    pub fn concatenated_binary(n: i32) -> i32 {
        let modulo = 1_000_000_007;
        let mut result: i64 = 0;
        let mut bit_count = 0;
        for i in 1..=n {
            if (i & (i - 1)) == 0 {
                bit_count += 1;
            }
            result = ((result << bit_count) % modulo + i as i64) % modulo;
        }
        result as i32
    }
}