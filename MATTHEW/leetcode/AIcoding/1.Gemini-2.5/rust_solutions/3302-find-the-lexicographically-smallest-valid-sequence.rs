impl Solution {
    pub fn find_lexicographically_smallest_valid_sequence(n: i32) -> Vec<i32> {
        let len = (2 * n - 1) as usize;
        let mut result = vec![0; len];
        let mut used = vec![false; (n + 1) as usize];

        Self::backtrack(0, n, &mut result, &mut used);

        result
    }

    fn backtrack(
        index: usize,
        n: i32,
        result: &mut Vec<i32>,
        used: &mut Vec<bool>,
    ) -> bool {
        let len = result.len();

        if index == len {
            return true;
        }

        if result[index] != 0 {
            return Self::backtrack(index + 1, n, result, used);
        }

        for k in 1..=n {
            if !used[k as usize] {
                if k == 1 {
                    result[index] = 1;
                    used[k as usize] = true;

                    if Self::backtrack(index + 1, n, result, used) {
                        return true;
                    }

                    used[k as usize] = false;
                    result[index] = 0;
                } else {
                    let second_pos = index + k as usize;

                    if second_pos < len && result[second_pos] == 0 {
                        result[index] = k;
                        result[second_pos] = k;
                        used[k as usize] = true;

                        if Self::backtrack(index + 1, n, result, used) {
                            return true;
                        }

                        used[k as usize] = false;
                        result[index] = 0;
                        result[second_pos] = 0;
                    }
                }
            }
        }

        false
    }
}