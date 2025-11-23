impl Solution {
    pub fn combine(n: i32, k: i32) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut current_combination: Vec<i32> = Vec::new();

        Self::backtrack(n, k, 1, &mut current_combination, &mut result);

        result
    }

    fn backtrack(
        n: i32,
        k: i32,
        start_num: i32,
        current_combination: &mut Vec<i32>,
        result: &mut Vec<Vec<i32>>,
    ) {
        if current_combination.len() == k as usize {
            result.push(current_combination.clone());
            return;
        }

        // Optimization: calculate the maximum possible value for `i`
        // We need `k - current_combination.len()` more elements.
        // These elements must be chosen from `i` to `n`.
        // So, `n - i + 1` (number of available elements) must be at least `k - current_combination.len()` (number of needed elements).
        // n - i + 1 >= k - current_combination.len()
        // n + 1 - (k - current_combination.len()) >= i
        // So, `i` can go up to `n - (k - current_combination.len()) + 1`.
        let upper_bound = n - (k - current_combination.len() as i32) + 1;

        for i in start_num..=upper_bound {
            current_combination.push(i);
            Self::backtrack(n, k, i + 1, current_combination, result);
            current_combination.pop();
        }
    }
}