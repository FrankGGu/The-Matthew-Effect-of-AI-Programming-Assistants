struct Solution;

impl Solution {
    pub fn count_arrangement(n: i32) -> i32 {
        let n = n as usize;
        let mut visited = vec![false; n + 1];
        Self::backtrack(1, &mut visited, n)
    }

    fn backtrack(k: usize, visited: &mut Vec<bool>, n: usize) -> i32 {
        if k > n {
            return 1;
        }
        let mut count = 0;
        for i in 1..=n {
            if !visited[i] && (k % i == 0 || i % k == 0) {
                visited[i] = true;
                count += Self::backtrack(k + 1, visited, n);
                visited[i] = false;
            }
        }
        count
    }
}