impl Solution {
    pub fn count_triplets(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] ^ arr[i];
        }
        let mut res = 0;
        for i in 0..n {
            for j in i + 1..n {
                for k in j..n {
                    let a = prefix[j] ^ prefix[i];
                    let b = prefix[k + 1] ^ prefix[j];
                    if a == b {
                        res += 1;
                    }
                }
            }
        }
        res
    }
}