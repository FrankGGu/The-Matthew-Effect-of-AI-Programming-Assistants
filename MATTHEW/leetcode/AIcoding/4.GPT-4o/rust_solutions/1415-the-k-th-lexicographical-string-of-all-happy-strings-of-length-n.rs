impl Solution {
    pub fn get_happy_string(n: i32, k: i32) -> String {
        let mut result = String::new();
        let mut count = 0;
        let chars = ['a', 'b', 'c'];

        fn generate_happy_strings(n: i32, current: &mut String, count: &mut i32, k: i32, chars: &[char]) {
            if current.len() as i32 == n {
                *count += 1;
                if *count == k {
                    result = current.clone();
                }
                return;
            }
            for &ch in chars.iter() {
                if current.is_empty() || current.chars().last().unwrap() != ch {
                    current.push(ch);
                    generate_happy_strings(n, current, count, k, chars);
                    current.pop();
                }
            }
        }

        let mut current = String::new();
        generate_happy_strings(n, &mut current, &mut count, k, &chars);
        result
    }
}