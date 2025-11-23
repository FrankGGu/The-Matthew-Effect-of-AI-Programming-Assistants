use std::collections::HashSet;

impl Solution {
    pub fn grid_illumination(n: i32, lamps: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut row = vec![0; n as usize];
        let mut col = vec![0; n as usize];
        let mut diag1 = std::collections::HashMap::new();
        let mut diag2 = std::collections::HashMap::new();
        let mut lamps_set = HashSet::new();

        for lamp in &lamps {
            let r = lamp[0];
            let c = lamp[1];
            if lamps_set.contains(&(r, c)) {
                continue;
            }
            lamps_set.insert((r, c));
            row[r as usize] += 1;
            col[c as usize] += 1;
            *diag1.entry(r - c).or_insert(0) += 1;
            *diag2.entry(r + c).or_insert(0) += 1;
        }

        let mut result = Vec::new();
        for query in &queries {
            let r = query[0];
            let c = query[1];
            if row[r as usize] > 0 || col[c as usize] > 0 || diag1.get(&(r - c)).unwrap_or(&0) > &0 || diag2.get(&(r + c)).unwrap_or(&0) > &0 {
                result.push(1);
                for i in -1..=1 {
                    for j in -1..=1 {
                        let nr = r + i;
                        let nc = c + j;
                        if nr >= 0 && nr < n && nc >= 0 && nc < n && lamps_set.contains(&(nr, nc)) {
                            lamps_set.remove(&(nr, nc));
                            row[nr as usize] -= 1;
                            col[nc as usize] -= 1;
                            *diag1.entry(nr - nc).or_insert(0) -= 1;
                            if diag1.get(&(nr - nc)).unwrap_or(&0) == &0 {
                                diag1.remove(&(nr - nc));
                            }
                            *diag2.entry(nr + nc).or_insert(0) -= 1;
                            if diag2.get(&(nr + nc)).unwrap_or(&0) == &0 {
                                diag2.remove(&(nr + nc));
                            }
                        }
                    }
                }
            } else {
                result.push(0);
            }
        }

        result
    }
}