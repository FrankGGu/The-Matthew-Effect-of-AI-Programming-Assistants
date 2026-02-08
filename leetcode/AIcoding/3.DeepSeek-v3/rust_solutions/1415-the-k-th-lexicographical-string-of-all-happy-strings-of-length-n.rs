impl Solution {
    pub fn get_happy_string(n: i32, k: i32) -> String {
        let mut count = 0;
        let mut result = String::new();
        let mut path = Vec::with_capacity(n as usize);
        let chars = ['a', 'b', 'c'];

        Self::backtrack(&chars, n as usize, &mut path, &mut count, k, &mut result);

        result
    }

    fn backtrack(chars: &[char], n: usize, path: &mut Vec<char>, count: &mut i32, k: i32, result: &mut String) {
        if !result.is_empty() {
            return;
        }

        if path.len() == n {
            *count += 1;
            if *count == k {
                *result = path.iter().collect();
            }
            return;
        }

        for &c in chars {
            if path.last().map_or(true, |&last| last != c) {
                path.push(c);
                Self::backtrack(chars, n, path, count, k, result);
                path.pop();
            }
        }
    }
}