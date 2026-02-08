struct Solution;

impl Solution {
    fn backtrack(
        n: i32,
        index: i32,
        visited: &mut Vec<bool>,
        count: &mut i32,
    ) {
        if index > n {
            *count += 1;
            return;
        }

        for num in 1..=n {
            if !visited[num as usize] && (num % index == 0 || index % num == 0) {
                visited[num as usize] = true;
                Self::backtrack(n, index + 1, visited, count);
                visited[num as usize] = false;
            }
        }
    }

    pub fn count_arrangement(n: i32) -> i32 {
        let mut visited = vec![false; (n + 1) as usize];
        let mut count = 0;
        Self::backtrack(n, 1, &mut visited, &mut count);
        count
    }
}