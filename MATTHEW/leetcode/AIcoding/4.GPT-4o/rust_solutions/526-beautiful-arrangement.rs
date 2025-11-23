pub fn count_arrangement(n: i32) -> i32 {
    let mut count = 0;
    let mut visited = vec![false; n as usize + 1];

    fn backtrack(n: i32, k: i32, visited: &mut Vec<bool>, count: &mut i32) {
        if k > n {
            *count += 1;
            return;
        }
        for i in 1..=n {
            if !visited[i as usize] && (i % k == 0 || k % i == 0) {
                visited[i as usize] = true;
                backtrack(n, k + 1, visited, count);
                visited[i as usize] = false;
            }
        }
    }

    backtrack(n, 1, &mut visited, &mut count);
    count
}