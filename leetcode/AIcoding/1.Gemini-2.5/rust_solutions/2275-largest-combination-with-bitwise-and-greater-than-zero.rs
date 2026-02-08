impl Solution {
    pub fn largest_combination(candidates: Vec<i32>) -> i32 {
        let mut max_count = 0;

        // Iterate through each bit position from 0 to 30 (since 10^9 < 2^30)
        for i in 0..31 {
            let mut current_bit_count = 0;
            // Check how many numbers in the candidates array have the i-th bit set
            for &num in candidates.iter() {
                if (num >> i) & 1 == 1 {
                    current_bit_count += 1;
                }
            }
            // Update the maximum count found so far
            if current_bit_count > max_count {
                max_count = current_bit_count;
            }
        }

        max_count
    }
}