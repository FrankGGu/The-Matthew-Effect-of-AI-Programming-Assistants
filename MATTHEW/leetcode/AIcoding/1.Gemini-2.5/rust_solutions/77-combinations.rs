impl Solution {
    pub fn combine(n: i32, k: i32) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut current_combination: Vec<i32> = Vec::new();
        Self::backtrack(n, k, 1, &mut current_combination, &mut result);
        result
    }

    fn backtrack(n: i32, k: i32, start: i32, current_combination: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
        if current_combination.len() == k as usize {
            result.push(current_combination.clone());
            return;
        }

        for i in start..=n {
            // Pruning: if the number of elements already in current_combination
            // plus the number of remaining elements available from 'i' to 'n'
            // is less than 'k', then it's impossible to form a combination of size 'k'.
            if (current_combination.len() as i32) + (n - i + 1) < k {
                break;
            }

            current_combination.push(i);
            Self::backtrack(n, k, i + 1, current_combination, result);
            current_combination.pop();
        }
    }
}