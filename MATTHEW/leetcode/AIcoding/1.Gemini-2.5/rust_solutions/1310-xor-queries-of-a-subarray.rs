impl Solution {
    pub fn xor_queries(arr: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = arr.len();
        let mut prefix_xor = vec![0; n + 1];

        for i in 0..n {
            prefix_xor[i + 1] = prefix_xor[i] ^ arr[i];
        }

        let mut results = Vec::with_capacity(queries.len());
        for query in queries {
            let l = query[0] as usize;
            let r = query[1] as usize;
            results.push(prefix_xor[r + 1] ^ prefix_xor[l]);
        }

        results
    }
}