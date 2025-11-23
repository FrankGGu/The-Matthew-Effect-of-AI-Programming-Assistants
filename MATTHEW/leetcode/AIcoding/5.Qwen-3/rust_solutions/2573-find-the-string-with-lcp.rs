impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn find_string(lcp: Vec<Vec<i32>>) -> String {
        let n = lcp.len();
        let mut result = vec!['\0'; n];
        let mut used = vec![false; 26];
        let mut char_code = 0;

        for i in 0..n {
            if result[i] != '\0' {
                continue;
            }

            let mut c = (b'a' + char_code) as char;
            while used[char_code as usize] {
                char_code += 1;
                c = (b'a' + char_code) as char;
            }
            used[char_code as usize] = true;
            result[i] = c;
            char_code += 1;

            for j in i + 1..n {
                if lcp[i][j] > 0 {
                    if result[j] == '\0' {
                        result[j] = c;
                    } else if result[j] != c {
                        return "-1".to_string();
                    }
                }
            }
        }

        result.into_iter().collect()
    }
}
}