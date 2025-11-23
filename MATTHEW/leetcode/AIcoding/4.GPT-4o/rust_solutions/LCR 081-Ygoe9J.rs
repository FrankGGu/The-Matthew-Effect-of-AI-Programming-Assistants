impl Solution {
    pub fn combination_sum(candidates: Vec<i32>, target: i32) -> Vec<Vec<i32>> {
        fn backtrack(candidates: &Vec<i32>, target: i32, start: usize, path: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
            if target == 0 {
                result.push(path.clone());
                return;
            }
            for i in start..candidates.len() {
                if candidates[i] > target {
                    continue;
                }
                path.push(candidates[i]);
                backtrack(candidates, target - candidates[i], i, path, result);
                path.pop();
            }
        }
        let mut result = Vec::new();
        let mut path = Vec::new();
        backtrack(&candidates, target, 0, &mut path, &mut result);
        result
    }
}