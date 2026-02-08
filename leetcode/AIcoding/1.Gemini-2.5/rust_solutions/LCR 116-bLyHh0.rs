impl Solution {
    pub fn find_circle_num(is_connected: Vec<Vec<i32>>) -> i32 {
        let n = is_connected.len();
        if n == 0 {
            return 0;
        }

        let mut visited = vec![false; n];
        let mut provinces = 0;

        for i in 0..n {
            if !visited[i] {
                provinces += 1;
                Self::dfs(i, &is_connected, &mut visited);
            }
        }
        provinces
    }

    fn dfs(city: usize, is_connected: &Vec<Vec<i32>>, visited: &mut Vec<bool>) {
        visited[city] = true;
        let n = is_connected.len();
        for neighbor in 0..n {
            if is_connected[city][neighbor] == 1 && !visited[neighbor] {
                Self::dfs(neighbor, is_connected, visited);
            }
        }
    }
}