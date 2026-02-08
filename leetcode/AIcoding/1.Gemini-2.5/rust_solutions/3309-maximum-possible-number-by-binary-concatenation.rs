impl Solution {
    pub fn concatenated_binary(n: i32) -> i32 {
        let modulo: i64 = 1_000_000_007;
        let mut result: i64 = 0;
        let mut length: i32 = 0; // Represents the number of bits for the current number 'i'

        for i in 1..=n {
            // If 'i' is a power of 2, it means the number of bits required to represent 'i'
            // is one more than the previous number.
            // Example: 1 (1 bit), 2 (2 bits), 3 (2 bits), 4 (3 bits), 5 (3 bits)
            // This condition checks if 'i' is a power of 2.
            if (i & (i - 1)) == 0 {
                length += 1;
            }

            // Shift the current 'result' by 'length' bits to make space for the binary representation of 'i'.
            // Apply modulo operation to keep the number within limits.
            result = (result << length) % modulo;

            // Add 'i' to the shifted result.
            // Apply modulo operation again.
            result = (result + i as i64) % modulo;
        }

        result as i32
    }
}