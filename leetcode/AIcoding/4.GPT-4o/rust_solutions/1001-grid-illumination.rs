use std::collections::{HashSet, HashMap};

impl Solution {
    pub fn grid_illumination(n: i32, lamps: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut rows = vec![0; n as usize];
        let mut cols = vec![0; n as usize];
        let mut diagonals1 = vec![0; 2 * n as usize];
        let mut diagonals2 = vec![0; 2 * n as usize];
        let mut lamp_set = HashSet::new();

        for lamp in &lamps {
            let (x, y) = (lamp[0], lamp[1]);
            lamp_set.insert((x, y));
            rows[x as usize] += 1;
            cols[y as usize] += 1;
            diagonals1[(x - y + (n - 1)) as usize] += 1;
            diagonals2[(x + y) as usize] += 1;
        }

        let mut result = Vec::new();
        for query in queries {
            let (x, y) = (query[0], query[1]);
            if rows[x as usize] > 0 || cols[y as usize] > 0 || diagonals1[(x - y + (n - 1)) as usize] > 0 || diagonals2[(x + y) as usize] > 0 {
                result.push(1);
            } else {
                result.push(0);
            }

            for dx in -1..=1 {
                for dy in -1..=1 {
                    let (nx, ny) = (x + dx, y + dy);
                    if nx >= 0 && nx < n && ny >= 0 && ny < n && lamp_set.remove(&(nx, ny)) {
                        rows[nx as usize] -= 1;
                        cols[ny as usize] -= 1;
                        diagonals1[(nx - ny + (n - 1)) as usize] -= 1;
                        diagonals2[(nx + ny) as usize] -= 1;
                    }
                }
            }
        }
        result
    }
}