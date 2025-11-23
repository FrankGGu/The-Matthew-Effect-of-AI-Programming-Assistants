impl Solution {
    pub fn combination_sum2(candidates: Vec<i32>, target: i32) -> Vec<Vec<i32>> {
        let mut results = Vec::new();
        let mut combination = Vec::new();
        let mut candidates = candidates;
        candidates.sort();
        Self::backtrack(&candidates, target, 0, &mut combination, &mut results);
        results
    }

    fn backtrack(candidates: &Vec<i32>, target: i32, start: usize, combination: &mut Vec<i32>, results: &mut Vec<Vec<i32>>) {
        if target == 0 {
            results.push(combination.clone());
            return;
        }
        for i in start..candidates.len() {
            if i > start && candidates[i] == candidates[i - 1] {
                continue;
            }
            if candidates[i] > target {
                break;
            }
            combination.push(candidates[i]);
            Self::backtrack(candidates, target - candidates[i], i + 1, combination, results);
            combination.pop();
        }
    }
}