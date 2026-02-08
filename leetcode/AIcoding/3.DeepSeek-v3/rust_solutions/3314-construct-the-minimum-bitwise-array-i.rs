impl Solution {
    pub fn construct_minimum_bitwise_array(n: i32, x: i32) -> Vec<i32> {
        let mut res = vec![0; n as usize];
        for i in 0..n {
            res[i as usize] = i | x;
        }
        res
    }
}