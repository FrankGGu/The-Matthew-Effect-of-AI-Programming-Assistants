impl Solution {
    pub fn construct_largest_valid_sequence(n: i32) -> Vec<i32> {
        let len = (2 * n - 1) as usize;
        let mut result = vec![0; len];
        let mut used = vec![false; (n + 1) as usize];

        fn backtrack(
            idx: usize,
            n: i32,
            result: &mut Vec<i32>,
            used: &mut Vec<bool>,
        ) -> bool {
            let len = result.len();
            if idx == len {
                return true;
            }

            if result[idx] != 0 {
                return backtrack(idx + 1, n, result, used);
            }

            for num in (1..=n).rev() {
                if used[num as usize] {
                    continue;
                }

                if num == 1 {
                    result[idx] = num;
                    used[num as usize] = true;
                    if backtrack(idx + 1, n, result, used) {
                        return true;
                    }
                    used[num as usize] = false;
                    result[idx] = 0;
                } else {
                    let second_pos = idx + num as usize;
                    if second_pos < len && result[second_pos] == 0 {
                        result[idx] = num;
                        result[second_pos] = num;
                        used[num as usize] = true;
                        if backtrack(idx + 1, n, result, used) {
                            return true;
                        }
                        used[num as usize] = false;
                        result[idx] = 0;
                        result[second_pos] = 0;
                    }
                }
            }
            false
        }

        backtrack(0, n, &mut result, &mut used);
        result
    }
}