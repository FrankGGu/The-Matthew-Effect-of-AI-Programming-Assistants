impl Solution {
    pub fn combination_sum2(candidates: Vec<i32>, target: i32) -> Vec<Vec<i32>> {
        let mut candidates = candidates;
        candidates.sort();
        let mut res = Vec::new();
        let mut path = Vec::new();
        Self::dfs(&candidates, target, 0, &mut path, &mut res);
        res
    }

    fn dfs(candidates: &[i32], target: i32, start: usize, path: &mut Vec<i32>, res: &mut Vec<Vec<i32>>) {
        if target == 0 {
            res.push(path.clone());
            return;
        }
        for i in start..candidates.len() {
            if i > start && candidates[i] == candidates[i - 1] {
                continue;
            }
            if candidates[i] > target {
                break;
            }
            path.push(candidates[i]);
            Self::dfs(candidates, target - candidates[i], i + 1, path, res);
            path.pop();
        }
    }
}