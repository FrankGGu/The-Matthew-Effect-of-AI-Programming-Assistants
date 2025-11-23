impl Solution {
    pub fn is_printable(target_grid: Vec<Vec<i32>>) -> bool {
        let m = target_grid.len();
        if m == 0 {
            return true;
        }
        let n = target_grid[0].len();
        let mut colors = std::collections::HashSet::new();
        for i in 0..m {
            for j in 0..n {
                if target_grid[i][j] != 0 {
                    colors.insert(target_grid[i][j]);
                }
            }
        }
        let mut graph = std::collections::HashMap::new();
        for &color in &colors {
            let mut min_x = m;
            let mut min_y = n;
            let mut max_x = 0;
            let mut max_y = 0;
            for i in 0..m {
                for j in 0..n {
                    if target_grid[i][j] == color {
                        min_x = std::cmp::min(min_x, i);
                        min_y = std::cmp::min(min_y, j);
                        max_x = std::cmp::max(max_x, i);
                        max_y = std::cmp::max(max_y, j);
                    }
                }
            }
            let mut dependencies = std::collections::HashSet::new();
            for i in min_x..=max_x {
                for j in min_y..=max_y {
                    if target_grid[i][j] != color {
                        dependencies.insert(target_grid[i][j]);
                    }
                }
            }
            graph.insert(color, dependencies);
        }
        let mut in_degree = std::collections::HashMap::new();
        for &color in &colors {
            in_degree.insert(color, 0);
        }
        for &u in graph.keys() {
            for &v in graph[&u].iter() {
                *in_degree.get_mut(&v).unwrap() += 1;
            }
        }
        let mut queue = std::collections::VecDeque::new();
        for (&color, &degree) in &in_degree {
            if degree == 0 {
                queue.push_back(color);
            }
        }
        let mut count = 0;
        while !queue.is_empty() {
            let u = queue.pop_front().unwrap();
            count += 1;
            for &v in graph[&u].iter() {
                *in_degree.get_mut(&v).unwrap() -= 1;
                if in_degree[&v] == 0 {
                    queue.push_back(v);
                }
            }
        }
        count == colors.len()
    }
}