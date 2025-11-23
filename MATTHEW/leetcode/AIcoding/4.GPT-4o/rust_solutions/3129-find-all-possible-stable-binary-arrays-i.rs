impl Solution {
    pub fn find_stable_binary_arrays(n: i32) -> Vec<Vec<i32>> {
        fn backtrack(n: i32, start: i32, current: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
            if current.len() == n as usize {
                result.push(current.clone());
                return;
            }
            for i in start..=1 {
                current.push(i);
                backtrack(n, i, current, result);
                current.pop();
            }
        }

        let mut result = Vec::new();
        backtrack(n, 0, &mut Vec::new(), &mut result);
        result
    }
}