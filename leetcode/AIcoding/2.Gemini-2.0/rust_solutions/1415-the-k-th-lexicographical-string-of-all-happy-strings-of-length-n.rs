impl Solution {
    pub fn get_happy_string(n: i32, k: i32) -> String {
        let n = n as usize;
        let k = k as usize;

        let mut result = String::new();
        let mut count = 0;

        fn backtrack(n: usize, current: &mut String, count: &mut usize, k: usize, result: &mut String) {
            if current.len() == n {
                *count += 1;
                if *count == k {
                    *result = current.clone();
                }
                return;
            }

            if *count >= k {
                return;
            }

            let chars = ['a', 'b', 'c'];
            for &c in &chars {
                if current.is_empty() || current.chars().last().unwrap() != c {
                    current.push(c);
                    backtrack(n, current, count, k, result);
                    current.pop();
                }
            }
        }

        backtrack(n, &mut result, &mut count, k, &mut result);

        if result.len() == n {
            result
        } else {
            String::new()
        }
    }
}