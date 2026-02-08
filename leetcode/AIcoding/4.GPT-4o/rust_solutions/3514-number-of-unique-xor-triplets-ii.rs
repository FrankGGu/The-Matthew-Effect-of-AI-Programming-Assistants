impl Solution {
    pub fn count_triplets(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut prefix_xor = vec![0; n + 1];

        for i in 0..n {
            prefix_xor[i + 1] = prefix_xor[i] ^ arr[i];
        }

        let mut unique_xors = std::collections::HashSet::new();

        for i in 0..n {
            for j in i..n {
                let xor_value = prefix_xor[j + 1] ^ prefix_xor[i];
                unique_xors.insert(xor_value);
            }
        }

        unique_xors.len() as i32
    }
}