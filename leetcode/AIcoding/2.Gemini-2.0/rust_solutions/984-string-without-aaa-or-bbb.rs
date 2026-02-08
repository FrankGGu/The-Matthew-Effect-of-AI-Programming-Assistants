impl Solution {
    pub fn str_without_3a3b(a: i32, b: i32) -> String {
        let mut result = String::new();
        let mut a_count = a;
        let mut b_count = b;

        while a_count > 0 || b_count > 0 {
            if a_count > b_count {
                if a_count >= 2 && (result.len() < 2 || result.chars().last() != Some('a') || result.chars().nth(result.len() - 2) != Some('a')) {
                    result.push('a');
                    result.push('a');
                    a_count -= 2;
                } else {
                    result.push('a');
                    a_count -= 1;
                }

                if b_count > 0 {
                    result.push('b');
                    b_count -= 1;
                }
            } else if b_count > a_count {
                 if b_count >= 2 && (result.len() < 2 || result.chars().last() != Some('b') || result.chars().nth(result.len() - 2) != Some('b')) {
                    result.push('b');
                    result.push('b');
                    b_count -= 2;
                } else {
                    result.push('b');
                    b_count -= 1;
                }

                if a_count > 0 {
                    result.push('a');
                    a_count -= 1;
                }
            } else {
                if a_count > 0 {
                    result.push('a');
                    a_count -= 1;
                }
                if b_count > 0 {
                    result.push('b');
                    b_count -= 1;
                }
            }
        }

        result
    }
}