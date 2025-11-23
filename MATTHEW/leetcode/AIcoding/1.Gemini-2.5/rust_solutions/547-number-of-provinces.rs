impl Solution {
    pub fn find_circle_num(is_connected: Vec<Vec<i32>>) -> i32 {
        let n = is_connected.len();
        let mut visited = vec![false; n];
        let mut provinces = 0;

        for i in 0..n {
            if !visited[i] {
                provinces += 1;
                Self::dfs(i, n, &is_connected, &mut visited);
            }
        }

        provinces
    }

    fn dfs(city: usize, n: usize, is_connected: &Vec<Vec<i32>>, visited: &mut Vec<bool>) {
        visited[city] = true;
        for neighbor in 0..n {
            if is_connected[city][neighbor] == 1 && !visited[neighbor] {
                Self::dfs(neighbor, n, is_connected, visited);
            }
        }
    }
}