pub fn combine_files(files: Vec<String>, k: i32) -> Vec<String> {
    let n = files.len();
    let mut result = Vec::new();
    let mut combination = Vec::new();

    fn backtrack(files: &Vec<String>, k: i32, start: usize, combination: &mut Vec<String>, result: &mut Vec<String>) {
        if combination.len() == k as usize {
            result.push(combination.join(","));
            return;
        }
        for i in start..files.len() {
            combination.push(files[i].clone());
            backtrack(files, k, i + 1, combination, result);
            combination.pop();
        }
    }

    backtrack(&files, k, 0, &mut combination, &mut result);
    result
}