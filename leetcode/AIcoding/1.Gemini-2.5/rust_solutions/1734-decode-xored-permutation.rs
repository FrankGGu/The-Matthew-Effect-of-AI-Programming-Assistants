impl Solution {
    pub fn decode(encoded: Vec<i32>) -> Vec<i32> {
        let n = encoded.len() + 1;

        // Calculate the XOR sum of all numbers from 1 to n
        // X = p_0 XOR p_1 XOR ... XOR p_{n-1}
        let mut xor_all_nums = 0;
        for i in 1..=n {
            xor_all_nums ^= i as i32;
        }

        // Calculate the XOR sum of S_e_k = (e_0 XOR e_1 XOR ... XOR e_{k-1}) for k from 0 to n-1
        // Where S_e_0 = 0
        // total_S_e_xor = S_e_0 XOR S_e_1 XOR ... XOR S_e_{n-1}
        let mut current_prefix_xor_e = 0; // Represents S_e_k
        let mut total_S_e_xor = 0;        // Accumulates XOR of all S_e_k

        // Add S_e_0 = 0
        total_S_e_xor ^= current_prefix_xor_e;

        // Iterate through encoded to calculate S_e_1 to S_e_{n-1}
        for &e in encoded.iter() {
            current_prefix_xor_e ^= e; // Update current_prefix_xor_e to S_e_{k+1}
            total_S_e_xor ^= current_prefix_xor_e; // Add S_e_{k+1} to total_S_e_xor
        }

        // We know X = p_0 XOR total_S_e_xor (since n is odd, p_0 appears n times in the sum)
        // Therefore, p_0 = X XOR total_S_e_xor
        let p0 = xor_all_nums ^ total_S_e_xor;

        // Reconstruct the permutation array
        let mut perm = vec![0; n];
        perm[0] = p0;

        for i in 0..n - 1 {
            // p_{i+1} = p_i XOR encoded[i]
            perm[i + 1] = perm[i] ^ encoded[i];
        }

        perm
    }
}