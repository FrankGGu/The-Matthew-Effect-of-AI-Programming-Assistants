pub fn construct_valid_sequence(n: i32) -> String {
    let mut result = String::new();
    let mut used = vec![false; n as usize + 1];

    fn backtrack(result: &mut String, used: &mut Vec<bool>, n: i32) -> bool {
        if result.len() == (n * 2) as usize {
            return true;
        }

        for i in (1..=n).rev() {
            if !used[i as usize] {
                used[i as usize] = true;
                result.push_str(&i.to_string());
                if backtrack(result, used, n) {
                    return true;
                }
                result.truncate(result.len() - i.to_string().len());
                used[i as usize] = false;
            }
        }

        false
    }

    backtrack(&mut result, &mut used, n);
    result
}