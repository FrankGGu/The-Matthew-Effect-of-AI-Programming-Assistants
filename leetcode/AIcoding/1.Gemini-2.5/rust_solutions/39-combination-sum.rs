struct Solution;

impl Solution {
    pub fn combination_sum(candidates: Vec<i32>, target: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut current_combination = Vec::new();
        let mut sorted_candidates = candidates;
        sorted_candidates.sort_unstable();

        Self::backtrack(
            &sorted_candidates,
            target,
            0, // current_sum
            0, // start_index
            &mut current_combination,
            &mut result,
        );

        result
    }

    fn backtrack(
        candidates: &[i32],
        target: i32,
        current_sum: i32,
        start_index: usize,
        current_combination: &mut Vec<i32>,
        result: &mut Vec<Vec<i32>>,
    ) {
        if current_sum == target {
            result.push(current_combination.clone());
            return;
        }

        if current_sum > target {
            return;
        }

        for i in start_index..candidates.len() {
            let candidate = candidates[i];

            if current_sum + candidate > target {
                break; 
            }

            current_combination.push(candidate);
            Self::backtrack(
                candidates,
                target,
                current_sum + candidate,
                i, 
                current_combination,
                result,
            );
            current_combination.pop(); 
        }
    }
}