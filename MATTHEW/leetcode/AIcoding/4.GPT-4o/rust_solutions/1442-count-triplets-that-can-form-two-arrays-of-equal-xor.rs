impl Solution {
    pub fn count_triplets(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut prefix_xor = vec![0; n + 1];
        for i in 0..n {
            prefix_xor[i + 1] = prefix_xor[i] ^ arr[i];
        }

        let mut count = 0;
        for i in 0..n {
            for j in i..n {
                let xor = prefix_xor[j + 1] ^ prefix_xor[i];
                count += if xor == 0 { (j - i + 1) as i32 } else { 0 };
            }
        }

        count
    }
}