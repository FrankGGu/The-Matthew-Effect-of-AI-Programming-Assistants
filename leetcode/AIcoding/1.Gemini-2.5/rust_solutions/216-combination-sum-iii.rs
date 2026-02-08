impl Solution {
    pub fn combination_sum3(k: i32, n: i32) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut current_combination: Vec<i32> = Vec::new();

        Self::backtrack(k, n, 1, &mut current_combination, &mut result);

        result
    }

    fn backtrack(k: i32, n: i32, start_num: i32, current_combination: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
        if k == 0 && n == 0 {
            result.push(current_combination.clone());
            return;
        }

        if k == 0 || n < 0 || start_num > 9 {
            return;
        }

        for num in start_num..=9 {
            if num > n { // Optimization: if current number is already greater than remaining sum, no need to proceed
                break;
            }
            current_combination.push(num);
            Self::backtrack(k - 1, n - num, num + 1, current_combination, result);
            current_combination.pop();
        }
    }
}