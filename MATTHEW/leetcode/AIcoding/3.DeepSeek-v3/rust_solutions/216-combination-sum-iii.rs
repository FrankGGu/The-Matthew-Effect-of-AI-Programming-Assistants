impl Solution {
    pub fn combination_sum3(k: i32, n: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut current = Vec::new();
        Self::backtrack(k, n, 1, &mut current, &mut result);
        result
    }

    fn backtrack(k: i32, remaining: i32, start: i32, current: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
        if remaining == 0 && current.len() == k as usize {
            result.push(current.clone());
            return;
        }
        if remaining < 0 || current.len() >= k as usize {
            return;
        }
        for i in start..=9 {
            current.push(i);
            Self::backtrack(k, remaining - i, i + 1, current, result);
            current.pop();
        }
    }
}