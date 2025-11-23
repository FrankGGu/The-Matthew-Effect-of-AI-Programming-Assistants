impl Solution {
    pub fn combine(n: i32, k: i32) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut current: Vec<i32> = Vec::new();

        fn backtrack(n: i32, k: i32, start: i32, current: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
            if current.len() == k as usize {
                result.push(current.clone());
                return;
            }

            for i in start..=n {
                current.push(i);
                backtrack(n, k, i + 1, current, result);
                current.pop();
            }
        }

        backtrack(n, k, 1, &mut current, &mut result);
        result
    }
}