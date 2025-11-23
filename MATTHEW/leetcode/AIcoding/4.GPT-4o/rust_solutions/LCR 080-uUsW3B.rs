impl Solution {
    pub fn combine(n: i32, k: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut combination = Vec::new();
        Self::backtrack(&mut result, &mut combination, n, k, 1);
        result
    }

    fn backtrack(result: &mut Vec<Vec<i32>>, combination: &mut Vec<i32>, n: i32, k: i32, start: i32) {
        if combination.len() as i32 == k {
            result.push(combination.clone());
            return;
        }
        for i in start..=n {
            combination.push(i);
            Self::backtrack(result, combination, n, k, i + 1);
            combination.pop();
        }
    }
}