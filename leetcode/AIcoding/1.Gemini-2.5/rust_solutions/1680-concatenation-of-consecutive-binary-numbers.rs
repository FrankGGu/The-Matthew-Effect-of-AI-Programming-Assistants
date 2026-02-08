impl Solution {
    pub fn concatenated_binary(n: i32) -> i32 {
        let modulo: u64 = 1_000_000_007;
        let mut result: u64 = 0;
        let mut current_bit_length: u32 = 0;
        let mut current_power_of_2: u32 = 1;

        for i in 1..=n {
            if i as u32 == current_power_of_2 {
                current_bit_length += 1;
                current_power_of_2 *= 2;
            }
            result = (result << current_bit_length) | (i as u64);
            result %= modulo;
        }

        result as i32
    }
}