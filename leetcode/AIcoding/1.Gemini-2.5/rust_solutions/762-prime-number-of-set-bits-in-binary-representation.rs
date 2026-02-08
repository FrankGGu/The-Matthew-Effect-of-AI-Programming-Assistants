impl Solution {
    pub fn count_prime_set_bits(left: i32, right: i32) -> i32 {
        let mut count = 0;
        // Primes up to 20.
        // The maximum number of set bits for a number up to 10^6 (2^19.9) is 20.
        // (e.g., 2^20 - 1 = 1048575 has 20 set bits)
        // primes_lookup[i] is true if i is a prime number, false otherwise.
        // Index 0 to 20 are covered.
        let primes_lookup: [bool; 21] = [
            false, // 0
            false, // 1
            true,  // 2
            true,  // 3
            false, // 4
            true,  // 5
            false, // 6
            true,  // 7
            false, // 8
            false, // 9
            false, // 10
            true,  // 11
            false, // 12
            true,  // 13
            false, // 14
            false, // 15
            false, // 16
            true,  // 17
            false, // 18
            true,  // 19
            false, // 20
        ];

        for i in left..=right {
            let set_bits = i.count_ones() as usize;
            if primes_lookup[set_bits] {
                count += 1;
            }
        }
        count
    }
}