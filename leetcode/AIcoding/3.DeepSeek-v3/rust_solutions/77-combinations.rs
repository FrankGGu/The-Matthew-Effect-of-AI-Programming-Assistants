impl Solution {
    pub fn combine(n: i32, k: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut current = Vec::new();
        Self::backtrack(1, n, k, &mut current, &mut result);
        result
    }

    fn backtrack(start: i32, n: i32, k: i32, current: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
        if current.len() == k as usize {
            result.push(current.clone());
            return;
        }

        for i in start..=n {
            current.push(i);
            Self::backtrack(i + 1, n, k, current, result);
            current.pop();
        }
    }
}