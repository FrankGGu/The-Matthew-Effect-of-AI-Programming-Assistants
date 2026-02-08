struct Solution;

impl Solution {
    pub fn split_into_fibonacci(num: String) -> Vec<i32> {
        let num_bytes = num.as_bytes();
        let mut path: Vec<i32> = Vec::new();
        let mut result: Vec<i32> = Vec::new();

        if Self::backtrack(0, &mut path, num_bytes, &mut result) {
            result
        } else {
            Vec::new()
        }
    }

    fn backtrack(
        index: usize,
        path: &mut Vec<i32>,
        num_bytes: &[u8],
        result: &mut Vec<i32>,
    ) -> bool {
        if index == num_bytes.len() {
            return path.len() >= 3;
        }

        // A number in i32 can have at most 10 digits (e.g., 2,147,483,647)
        let max_possible_len = (num_bytes.len() - index).min(10);

        for i in 0..max_possible_len {
            let end_idx = index + i + 1;
            let current_slice = &num_bytes[index..end_idx];

            if current_slice.len() > 1 && current_slice[0] == b'0' {
                break;
            }

            let current_num_str = unsafe { std::str::from_utf8_unchecked(current_slice) };
            let current_num_res = current_num_str.parse::<i32>();

            let current_num = match current_num_res {
                Ok(val) => val,
                Err(_) => {
                    break;
                }
            };

            if path.len() < 2 {
                path.push(current_num);
                if Self::backtrack(end_idx, path, num_bytes, result) {
                    *result = path.clone();
                    return true;
                }
                path.pop();
            } else {
                let sum = path[path.len() - 1] + path[path.len() - 2];

                if current_num < sum {
                    continue;
                } else if current_num > sum {
                    break;
                } else { // current_num == sum
                    path.push(current_num);
                    if Self::backtrack(end_idx, path, num_bytes, result) {
                        *result = path.clone();
                        return true;
                    }
                    path.pop();
                }
            }
        }

        false
    }
}