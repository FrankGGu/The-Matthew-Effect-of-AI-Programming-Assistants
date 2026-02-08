impl Solution {
    pub fn split_into_fibonacci(s: String) -> Vec<i32> {
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();
        let mut result: Vec<i32> = Vec::new();

        fn backtrack(
            index: usize,
            current: &mut Vec<i32>,
            chars: &Vec<char>,
            n: usize,
        ) -> bool {
            if index == n && current.len() >= 3 {
                return true;
            }

            for i in index..n {
                if i > index && chars[index] == '0' {
                    break;
                }
                let num_str: String = chars[index..=i].iter().collect();
                if let Ok(num) = num_str.parse::<i64>() {
                    if num > i32::MAX as i64 {
                        break;
                    }

                    let num_i32 = num as i32;

                    if current.len() >= 2 {
                        let a = current[current.len() - 2] as i64;
                        let b = current[current.len() - 1] as i64;

                        if a + b > i32::MAX as i64 {
                            break;
                        }

                        if a + b < num as i64 {
                            continue;
                        }

                        if a + b > num as i64 {
                            break;
                        }
                    }

                    current.push(num_i32);
                    if backtrack(i + 1, current, chars, n) {
                        return true;
                    }
                    current.pop();
                } else {
                    break;
                }
            }

            false
        }

        backtrack(0, &mut result, &chars, n);

        result
    }
}