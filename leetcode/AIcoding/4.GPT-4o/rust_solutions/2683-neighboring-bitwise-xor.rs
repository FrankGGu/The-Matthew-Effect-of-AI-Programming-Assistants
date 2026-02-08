impl Solution {
    pub fn xor_neighbouring_bits(n: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let mut prev_bit = 0;

        for i in 0..32 {
            let current_bit = (n >> i) & 1;
            let xor_result = current_bit ^ prev_bit;
            result.push(xor_result);
            prev_bit = current_bit;
        }

        result.reverse();
        result
    }
}