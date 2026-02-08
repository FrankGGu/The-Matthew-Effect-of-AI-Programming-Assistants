impl Solution {
    pub fn num_splits(s: String) -> i32 {
        let n = s.len();
        let mut left_count = vec![0; n + 1];
        let mut right_count = vec![0; n + 1];

        let mut left_set = std::collections::HashSet::new();
        let mut right_set = std::collections::HashSet::new();

        for i in 0..n {
            left_set.insert(s.chars().nth(i).unwrap());
            left_count[i + 1] = left_set.len();
        }

        for i in (0..n).rev() {
            right_set.insert(s.chars().nth(i).unwrap());
            right_count[i] = right_set.len();
        }

        let mut result = 0;
        for i in 1..n {
            if left_count[i] == right_count[i] {
                result += 1;
            }
        }

        result
    }
}