impl Solution {
    pub fn garden_no_adj(n: i32, paths: Vec<Vec<i32>>) -> Vec<i32> {
        let mut graph = vec![vec![]; n as usize];
        for path in paths {
            graph[path[0] as usize - 1].push(path[1] as usize - 1);
            graph[path[1] as usize - 1].push(path[0] as usize - 1);
        }

        let mut result = vec![0; n as usize];

        for i in 0..n {
            let mut used = [false; 5];
            for &neighbor in &graph[i as usize] {
                if result[neighbor] != 0 {
                    used[result[neighbor]] = true;
                }
            }
            for color in 1..=4 {
                if !used[color] {
                    result[i as usize] = color;
                    break;
                }
            }
        }

        result
    }
}