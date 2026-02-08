impl Solution {
    pub fn decode(encoded: Vec<i32>, first: i32) -> Vec<i32> {
        let n = encoded.len();
        let mut arr = Vec::with_capacity(n + 1);
        arr.push(first);

        for i in 0..n {
            let next_val = encoded[i] ^ arr[i];
            arr.push(next_val);
        }

        arr
    }
}