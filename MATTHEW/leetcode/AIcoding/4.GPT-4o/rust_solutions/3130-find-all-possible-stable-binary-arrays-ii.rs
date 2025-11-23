impl Solution {
    pub fn stable_binary_arrays(n: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut current = vec![0; n as usize];
        Self::backtrack(n as usize, 0, &mut current, &mut result);
        result
    }

    fn backtrack(n: usize, idx: usize, current: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
        if idx == n {
            result.push(current.clone());
            return;
        }

        current[idx] = 0;
        Self::backtrack(n, idx + 1, current, result);

        if idx == 0 || current[idx - 1] == 1 {
            current[idx] = 1;
            Self::backtrack(n, idx + 1, current, result);
        }
    }
}