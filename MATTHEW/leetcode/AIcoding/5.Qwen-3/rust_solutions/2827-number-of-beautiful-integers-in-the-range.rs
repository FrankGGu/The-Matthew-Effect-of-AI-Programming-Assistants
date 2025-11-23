struct Solution;

impl Solution {
    pub fn number_of_beautiful_integers(k: i32, query: Vec<Vec<i32>>) -> Vec<i32> {
        use std::collections::HashMap;

        fn is_beautiful(n: i32) -> bool {
            let s = n.to_string();
            let mut cnt = 0;
            for c in s.chars() {
                match c {
                    '4' | '7' => cnt += 1,
                    _ => {}
                }
            }
            cnt % 2 == 0
        }

        let mut result = Vec::new();
        for q in query {
            let l = q[0];
            let r = q[1];
            let mut count = 0;
            for i in l..=r {
                if is_beautiful(i) {
                    count += 1;
                }
            }
            result.push(count);
        }
        result
    }
}