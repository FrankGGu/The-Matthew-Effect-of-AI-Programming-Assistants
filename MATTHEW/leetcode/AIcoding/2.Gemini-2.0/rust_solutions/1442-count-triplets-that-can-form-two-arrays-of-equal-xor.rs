impl Solution {
    pub fn count_triplets(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut count = 0;
        for i in 0..n {
            let mut xor_sum = 0;
            for j in i..n {
                xor_sum ^= arr[j];
                let mut k_xor_sum = 0;
                for k in j + 1..n {
                    k_xor_sum ^= arr[k];
                    if xor_sum == k_xor_sum {
                        count += 1;
                    }
                }
            }
        }
        count
    }
}