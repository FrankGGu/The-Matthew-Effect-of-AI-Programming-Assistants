impl Solution {
    pub fn add_operators(num: String, target: i32) -> Vec<String> {
        let mut res = Vec::new();
        let num_chars: Vec<char> = num.chars().collect();
        Self::backtrack(&num_chars, target, 0, 0, 0, &mut String::new(), &mut res);
        res
    }

    fn backtrack(
        num: &[char],
        target: i32,
        index: usize,
        prev: i64,
        curr: i64,
        path: &mut String,
        res: &mut Vec<String>,
    ) {
        if index == num.len() {
            if curr == target as i64 {
                res.push(path.clone());
            }
            return;
        }

        let mut value = 0;
        let path_len = path.len();
        for i in index..num.len() {
            if i != index && num[index] == '0' {
                break;
            }
            value = value * 10 + (num[i] as i64 - '0' as i64);
            let str_val: String = num[index..=i].iter().collect();

            if index == 0 {
                path.push_str(&str_val);
                Self::backtrack(num, target, i + 1, value, value, path, res);
                path.truncate(path_len);
            } else {
                path.push('+');
                path.push_str(&str_val);
                Self::backtrack(num, target, i + 1, value, curr + value, path, res);
                path.truncate(path_len);

                path.push('-');
                path.push_str(&str_val);
                Self::backtrack(num, target, i + 1, -value, curr - value, path, res);
                path.truncate(path_len);

                path.push('*');
                path.push_str(&str_val);
                Self::backtrack(
                    num,
                    target,
                    i + 1,
                    prev * value,
                    curr - prev + prev * value,
                    path,
                    res,
                );
                path.truncate(path_len);
            }
        }
    }
}