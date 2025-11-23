struct Solution;

impl Solution {
    pub fn combination_sum2(mut candidates: Vec<i32>, target: i32) -> Vec<Vec<i32>> {
        candidates.sort_unstable();
        let mut result = Vec::new();
        let mut current_combination = Vec::new();
        Self::backtrack(
            0,
            &candidates,
            target,
            &mut current_combination,
            &mut result,
        );
        result
    }

    fn backtrack(
        start_index: usize,
        candidates: &[i32],
        target: i32,
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

            let num = candidates[i];

            if num > target {
                break; 
            }

            current_combination.push(num);
            Self::backtrack(
                i + 1,
                candidates,
                target - num,
                current_combination,
                result,
            );
            current_combination.pop();
        }
    }
}