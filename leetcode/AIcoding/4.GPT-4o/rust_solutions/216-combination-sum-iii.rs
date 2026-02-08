impl Solution {
    pub fn combination_sum3(k: i32, n: i32) -> Vec<Vec<i32>> {
        fn backtrack(start: i32, k: i32, n: i32, path: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
            if path.len() as i32 == k && n == 0 {
                result.push(path.clone());
                return;
            }
            for i in start..=9 {
                if i > n {
                    break;
                }
                path.push(i);
                backtrack(i + 1, k, n - i, path, result);
                path.pop();
            }
        }
        let mut result = Vec::new();
        backtrack(1, k, n, &mut Vec::new(), &mut result);
        result
    }
}