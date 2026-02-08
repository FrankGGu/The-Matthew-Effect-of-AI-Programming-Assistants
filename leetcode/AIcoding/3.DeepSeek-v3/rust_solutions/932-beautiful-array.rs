impl Solution {
    pub fn beautiful_array(n: i32) -> Vec<i32> {
        let mut res = vec![1];
        while res.len() < n as usize {
            let mut tmp = Vec::new();
            for &num in &res {
                if num * 2 - 1 <= n {
                    tmp.push(num * 2 - 1);
                }
            }
            for &num in &res {
                if num * 2 <= n {
                    tmp.push(num * 2);
                }
            }
            res = tmp;
        }
        res
    }
}