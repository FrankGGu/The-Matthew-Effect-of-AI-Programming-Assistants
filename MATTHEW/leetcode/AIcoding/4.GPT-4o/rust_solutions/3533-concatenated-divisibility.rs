impl Solution {
    pub fn concatenated_binary(n: i32) -> i32 {
        let mut result = 0;
        let mod_value = 1_000_000_007;

        for i in 1..=n {
            result = ((result << (i as f64).log(2.0).ceil() as i32) % mod_value + i) % mod_value);
        }

        result
    }
}