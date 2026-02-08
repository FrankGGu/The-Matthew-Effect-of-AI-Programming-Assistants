impl Solution {
    pub fn count_triplets(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut prefix_xor = vec![0; n + 1];

        for i in 0..n {
            prefix_xor[i + 1] = prefix_xor[i] ^ arr[i];
        }

        let mut count = 0;

        for i in 0..n {
            for k in i..n {
                if prefix_xor[i] == prefix_xor[k + 1] {
                    count += (k - i) as i32;
                }
            }
        }

        count
    }
}