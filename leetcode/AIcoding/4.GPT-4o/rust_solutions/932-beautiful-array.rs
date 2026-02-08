impl Solution {
    pub fn beautiful_array(n: i32) -> Vec<i32> {
        let mut result = vec![1];
        while result.len() < n as usize {
            result = result.iter().flat_map(|&x| vec![2 * x - 1, 2 * x]).collect();
        }
        result.into_iter().filter(|&x| x <= n).collect()
    }
}