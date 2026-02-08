impl Solution {
    pub fn combination_sum2(mut candidates: Vec<i32>, target: i32) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut current_combination: Vec<i32> = Vec::new();
        candidates.sort_unstable();

        Self::backtrack(
            &candidates,
            target,
            0,
            &mut current_combination,
            &mut result,
        );

        result
    }

    fn backtrack(
        candidates: &[i32],
        target: i32,
        start_index: usize,
        current_combination: &mut Vec<i32>,
        result: &mut Vec<Vec<i32>>,
    ) {
        if target == 0 {
            result.push(current_combination.clone());
            return;
        }

        if target < 0 {
            return;
        }

        for i in start_index..candidates.len() {
            if i > start_index && candidates[i] == candidates[i - 1] {
                continue;
            }

            if candidates[i] > target {
                break; 
            }

            current_combination.push(candidates[i]);
            Self::backtrack(
                candidates,
                target - candidates[i],
                i + 1, 
                current_combination,
                result,
            );
            current_combination.pop();
        }
    }
}