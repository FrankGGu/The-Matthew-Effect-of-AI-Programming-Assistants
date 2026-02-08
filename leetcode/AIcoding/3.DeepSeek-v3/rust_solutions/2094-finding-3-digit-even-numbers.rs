impl Solution {
    pub fn find_even_numbers(digits: Vec<i32>) -> Vec<i32> {
        use std::collections::HashSet;
        let mut result = HashSet::new();
        let n = digits.len();
        for i in 0..n {
            if digits[i] == 0 {
                continue;
            }
            for j in 0..n {
                if j == i {
                    continue;
                }
                for k in 0..n {
                    if k == i || k == j || digits[k] % 2 != 0 {
                        continue;
                    }
                    let num = digits[i] * 100 + digits[j] * 10 + digits[k];
                    result.insert(num);
                }
            }
        }
        let mut sorted_result: Vec<i32> = result.into_iter().collect();
        sorted_result.sort();
        sorted_result
    }
}