impl Solution {
    pub fn combine(n: i32, k: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut path = Vec::new();
        Self::backtrack(1, n, k, &mut path, &mut result);
        result
    }

    fn backtrack(start: i32, n: i32, k: i32, path: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
        if path.len() == k as usize {
            result.push(path.clone());
            return;
        }
        for i in start..=n {
            path.push(i);
            Self::backtrack(i + 1, n, k, path, result);
            path.pop();
        }
    }
}