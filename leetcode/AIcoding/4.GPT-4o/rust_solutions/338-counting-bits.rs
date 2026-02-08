impl Solution {
    pub fn count_bits(n: i32) -> Vec<i32> {
        let mut result = vec![0; (n + 1) as usize];
        for i in 1..=n {
            result[i as usize] = result[(i >> 1) as usize] + (i & 1);
        }
        result
    }
}