use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn is_printable(target_grid: Vec<Vec<i32>>) -> bool {
        let m = target_grid.len();
        let n = target_grid[0].len();

        let mut color_bounds: HashMap<i32, (usize, usize, usize, usize)> = HashMap::new();
        for i in 0..m {
            for j in 0..n {
                let color = target_grid[i][j];
                if let Some((min_r, min_c, max_r, max_c)) = color_bounds.get_mut(&color) {
                    *min_r = (*min_r).min(i);
                    *min_c = (*min_c).min(j);
                    *max_r = (*max_r).max(i);
                    *max_c = (*max_c).max(j);
                } else {
                    color_bounds.insert(color, (i, j, i, j));
                }
            }
        }

        let mut adj: HashMap<i32, Vec<i32>> = HashMap::new();
        let mut in_degree: HashMap<i32, i32> = HashMap::new();

        for (&color, _) in &color_bounds {
            adj.insert(color, Vec::new());
            in_degree.insert(color, 0);
        }

        for (&color1, &(min_r1, min_c1, max_r1, max_c1)) in &color_bounds {
            for (&color2, &(min_r2, min_c2, max_r2, max_c2)) in &color_bounds {
                if color1 == color2 {
                    continue;
                }

                let mut overlap = false;
                for i in min_r1..=max_r1 {
                    for j in min_c1..=max_c1 {
                        if target_grid[i][j] == color2 {
                            overlap = true;
                            break;
                        }
                    }
                    if overlap {
                        break;
                    }
                }

                if overlap {
                    adj.get_mut(&color2).unwrap().push(color1);
                    *in_degree.get_mut(&color1).unwrap() += 1;
                }
            }
        }

        let mut queue: VecDeque<i32> = VecDeque::new();
        for (&color, &degree) in &in_degree {
            if degree == 0 {
                queue.push_back(color);
            }
        }

        let mut count = 0;
        while let Some(color) = queue.pop_front() {
            count += 1;
            if let Some(neighbors) = adj.get(&color) {
                for &neighbor in neighbors {
                    *in_degree.get_mut(&neighbor).unwrap() -= 1;
                    if in_degree[&neighbor] == 0 {
                        queue.push_back(neighbor);
                    }
                }
            }
        }

        count == color_bounds.len()
    }
}