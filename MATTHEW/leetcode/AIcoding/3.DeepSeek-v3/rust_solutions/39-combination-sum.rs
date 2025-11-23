impl Solution {
    pub fn combination_sum(candidates: Vec<i32>, target: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut current = Vec::new();
        Self::backtrack(&candidates, target, 0, &mut current, &mut result);
        result
    }

    fn backtrack(
        candidates: &[i32],
        remaining: i32,
        start: usize,
        current: &mut Vec<i32>,
        result: &mut Vec<Vec<i32>>,
    ) {
        if remaining < 0 {
            return;
        }
        if remaining == 0 {
            result.push(current.clone());
            return;
        }
        for i in start..candidates.len() {
            current.push(candidates[i]);
            Self::backtrack(
                candidates,
                remaining - candidates[i],
                i,
                current,
                result,
            );
            current.pop();
        }
    }
}