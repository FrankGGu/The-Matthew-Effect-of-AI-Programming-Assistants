impl Solution {
    pub fn count_triplets(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut count = 0;

        for i in 0..n {
            for j in 0..n {
                for k in 0..n {
                    if i != j && j != k && i != k {
                        let xor_value = arr[i] ^ arr[j] ^ arr[k];
                        if xor_value == 0 {
                            count += 1;
                        }
                    }
                }
            }
        }

        count
    }
}