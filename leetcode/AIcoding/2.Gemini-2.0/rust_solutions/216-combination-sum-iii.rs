impl Solution {
    pub fn combination_sum3(k: i32, n: i32) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut combination: Vec<i32> = Vec::new();

        fn backtrack(k: i32, n: i32, start: i32, combination: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
            if combination.len() as i32 == k {
                if n == 0 {
                    result.push(combination.clone());
                }
                return;
            }

            for i in start..=9 {
                if n - i < 0 {
                    break;
                }

                combination.push(i);
                backtrack(k, n - i, i + 1, combination, result);
                combination.pop();
            }
        }

        backtrack(k, n, 1, &mut combination, &mut result);
        result
    }
}