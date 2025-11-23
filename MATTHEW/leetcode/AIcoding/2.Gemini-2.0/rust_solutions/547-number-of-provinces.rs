impl Solution {
    pub fn find_circle_num(is_connected: Vec<Vec<i32>>) -> i32 {
        let n = is_connected.len();
        let mut visited = vec![false; n];
        let mut count = 0;

        for i in 0..n {
            if !visited[i] {
                Self::dfs(i, &is_connected, &mut visited);
                count += 1;
            }
        }

        count
    }

    fn dfs(node: usize, is_connected: &Vec<Vec<i32>>, visited: &mut Vec<bool>) {
        visited[node] = true;

        for neighbor in 0..is_connected.len() {
            if is_connected[node][neighbor] == 1 && !visited[neighbor] {
                Self::dfs(neighbor, is_connected, visited);
            }
        }
    }
}