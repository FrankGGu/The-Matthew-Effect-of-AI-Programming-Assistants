impl Solution {
    pub fn combine(n: i32, k: i32) -> Vec<Vec<i32>> {
        fn backtrack(start: i32, n: i32, k: i32, path: &mut Vec<i32>, res: &mut Vec<Vec<i32>>) {
            if path.len() as i32 == k {
                res.push(path.clone());
                return;
            }
            for i in start..=n {
                path.push(i);
                backtrack(i + 1, n, k, path, res);
                path.pop();
            }
        }
        let mut res = Vec::new();
        let mut path = Vec::new();
        backtrack(1, n, k, &mut path, &mut res);
        res
    }
}