use std::collections::HashSet;

impl Solution {
    pub fn is_solvable(words: Vec<String>, result: String) -> bool {
        let mut chars = HashSet::new();
        let mut leading_zeros = HashSet::new();
        let mut letters = Vec::new();

        for word in &words {
            for (i, c) in word.chars().enumerate() {
                chars.insert(c);
                if i == 0 && word.len() > 1 {
                    leading_zeros.insert(c);
                }
            }
        }

        for (i, c) in result.chars().enumerate() {
            chars.insert(c);
            if i == 0 && result.len() > 1 {
                leading_zeros.insert(c);
            }
        }

        letters.extend(chars.into_iter());

        let mut assignment = vec![0; letters.len()];
        let mut used = vec![false; 10];

        fn solve(
            words: &Vec<String>,
            result: &String,
            letters: &Vec<char>,
            assignment: &mut Vec<i32>,
            used: &mut Vec<bool>,
            index: usize,
            leading_zeros: &HashSet<char>,
        ) -> bool {
            if index == letters.len() {
                let mut sum = 0;
                for word in words {
                    let mut num = 0;
                    for c in word.chars() {
                        let digit = assignment[letters.iter().position(|&x| x == c).unwrap()];
                        num = num * 10 + digit;
                    }
                    sum += num;
                }

                let mut result_num = 0;
                for c in result.chars() {
                    let digit = assignment[letters.iter().position(|&x| x == c).unwrap()];
                    result_num = result_num * 10 + digit;
                }

                return sum == result_num;
            }

            for digit in 0..10 {
                if used[digit] {
                    continue;
                }

                let letter = letters[index];
                if digit == 0 && leading_zeros.contains(&letter) {
                    continue;
                }

                assignment[index] = digit;
                used[digit] = true;

                if solve(words, result, letters, assignment, used, index + 1, leading_zeros) {
                    return true;
                }

                used[digit] = false;
            }

            false
        }

        solve(&words, &result, &letters, &mut assignment, &mut used, 0, &leading_zeros)
    }
}