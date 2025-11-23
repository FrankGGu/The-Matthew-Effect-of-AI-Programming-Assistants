struct Solution;

impl Solution {
    pub fn find_circle_moments(m: Vec<Vec<i32>>) -> i32 {
        let n = m.len();
        let mut visited = vec![false; n];
        let mut count = 0;

        for i in 0..n {
            if !visited[i] {
                count += 1;
                Self::dfs(i, &m, &mut visited);
            }
        }

        count
    }

    fn dfs(node: usize, m: &Vec<Vec<i32>>, visited: &mut Vec<bool>) {
        for neighbor in 0..m.len() {
            if m[node][neighbor] == 1 && !visited[neighbor] {
                visited[neighbor] = true;
                Self::dfs(neighbor, m, visited);
            }
        }
    }
}