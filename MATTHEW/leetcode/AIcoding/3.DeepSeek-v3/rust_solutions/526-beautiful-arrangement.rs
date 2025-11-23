impl Solution {
    pub fn count_arrangement(n: i32) -> i32 {
        let mut visited = vec![false; n as usize + 1];
        let mut count = 0;
        Self::backtrack(n, 1, &mut visited, &mut count);
        count
    }

    fn backtrack(n: i32, pos: i32, visited: &mut Vec<bool>, count: &mut i32) {
        if pos > n {
            *count += 1;
            return;
        }
        for i in 1..=n {
            if !visited[i as usize] && (i % pos == 0 || pos % i == 0) {
                visited[i as usize] = true;
                Self::backtrack(n, pos + 1, visited, count);
                visited[i as usize] = false;
            }
        }
    }
}