impl Solution {
    pub fn circular_permutation(n: i32, start: i32) -> Vec<i32> {
        let mut res = vec![0; 1 << n];
        for i in 0..(1 << n) {
            res[i] = start ^ i ^ (i >> 1);
        }
        res
    }
}