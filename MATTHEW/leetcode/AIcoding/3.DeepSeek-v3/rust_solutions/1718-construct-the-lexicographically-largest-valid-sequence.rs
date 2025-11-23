impl Solution {
    pub fn construct_distanced_sequence(n: i32) -> Vec<i32> {
        let mut result = vec![0; 2 * n as usize - 1];
        let mut used = vec![false; n as usize + 1];
        Self::backtrack(n as usize, &mut result, &mut used, 0);
        result
    }

    fn backtrack(n: usize, result: &mut Vec<i32>, used: &mut Vec<bool>, pos: usize) -> bool {
        if pos == result.len() {
            return true;
        }
        if result[pos] != 0 {
            return Self::backtrack(n, result, used, pos + 1);
        }
        for num in (1..=n).rev() {
            if used[num] {
                continue;
            }
            let next_pos = pos + num + 1;
            if num == 1 {
                if result[pos] == 0 {
                    result[pos] = num as i32;
                    used[num] = true;
                    if Self::backtrack(n, result, used, pos + 1) {
                        return true;
                    }
                    result[pos] = 0;
                    used[num] = false;
                }
            } else {
                if next_pos - 1 < result.len() && result[pos] == 0 && result[next_pos - 1] == 0 {
                    result[pos] = num as i32;
                    result[next_pos - 1] = num as i32;
                    used[num] = true;
                    if Self::backtrack(n, result, used, pos + 1) {
                        return true;
                    }
                    result[pos] = 0;
                    result[next_pos - 1] = 0;
                    used[num] = false;
                }
            }
        }
        false
    }
}