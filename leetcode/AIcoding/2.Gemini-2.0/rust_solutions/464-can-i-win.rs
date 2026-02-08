use std::collections::HashMap;

impl Solution {
    pub fn can_i_win(max_choosable_integer: i32, desired_total: i32) -> bool {
        if desired_total <= 0 {
            return true;
        }
        let max = max_choosable_integer as usize;
        if max * (max + 1) / 2 < desired_total {
            return false;
        }

        let mut memo: HashMap<i32, bool> = HashMap::new();
        let mut used = vec![false; max + 1];

        fn can_win(
            used: &mut Vec<bool>,
            desired_total: i32,
            memo: &mut HashMap<i32, bool>,
        ) -> bool {
            if desired_total <= 0 {
                return false;
            }

            let key = used.iter().enumerate().skip(1).fold(0, |acc, (i, &b)| {
                acc | ((b as i32) << (i - 1))
            });

            if let Some(&result) = memo.get(&key) {
                return result;
            }

            for i in 1..used.len() {
                if !used[i] {
                    used[i] = true;
                    let result = !can_win(used, desired_total - i as i32, memo);
                    used[i] = false;
                    memo.insert(key, result);
                    if result {
                        return true;
                    }
                }
            }

            memo.insert(key, false);
            false
        }

        can_win(&mut used, desired_total, &mut memo)
    }
}