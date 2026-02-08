struct Solution;

impl Solution {
    pub fn count_arrangement(n: i32) -> i32 {
        let mut count = 0;
        let mut visited = vec![false; n as usize + 1];

        Self::backtrack(1, n, &mut visited, &mut count);
        count
    }

    fn backtrack(pos: i32, n: i32, visited: &mut Vec<bool>, count: &mut i32) {
        if pos > n {
            *count += 1;
            return;
        }

        for num in 1..=n {
            if !visited[num as usize] && (num % pos == 0 || pos % num == 0) {
                visited[num as usize] = true;
                Self::backtrack(pos + 1, n, visited, count);
                visited[num as usize] = false;
            }
        }
    }
}