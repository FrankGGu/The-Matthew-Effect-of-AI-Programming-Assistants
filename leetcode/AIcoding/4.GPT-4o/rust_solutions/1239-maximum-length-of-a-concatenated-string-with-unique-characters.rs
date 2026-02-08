impl Solution {
    pub fn max_length(arr: Vec<String>) -> i32 {
        fn backtrack(arr: &[String], index: usize, current: String) -> i32 {
            if !current.chars().all(|c| current.matches(c).count() == 1) {
                return 0;
            }
            let mut max_len = current.len() as i32;
            for i in index..arr.len() {
                let new_current = format!("{}{}", current, arr[i]);
                max_len = max_len.max(backtrack(arr, i + 1, new_current));
            }
            max_len
        }
        backtrack(&arr, 0, String::new())
    }
}