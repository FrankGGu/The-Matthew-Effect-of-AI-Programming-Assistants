use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn grid_illumination(n: i32, lamps: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut lamp_set: HashSet<(i32, i32)> = HashSet::new();
        let mut row_counts: HashMap<i32, i32> = HashMap::new();
        let mut col_counts: HashMap<i32, i32> = HashMap::new();
        let mut diag_counts: HashMap<i32, i32> = HashMap::new(); // r - c
        let mut anti_diag_counts: HashMap<i32, i32> = HashMap::new(); // r + c

        for lamp in lamps {
            let r = lamp[0];
            let c = lamp[1];
            if lamp_set.insert((r, c)) {
                *row_counts.entry(r).or_insert(0) += 1;
                *col_counts.entry(c).or_insert(0) += 1;
                *diag_counts.entry(r - c).or_insert(0) += 1;
                *anti_diag_counts.entry(r + c).or_insert(0) += 1;
            }
        }

        let mut results: Vec<i32> = Vec::with_capacity(queries.len());

        for query in queries {
            let qr = query[0];
            let qc = query[1];

            let illuminated = row_counts.get(&qr).unwrap_or(&0) > &0
                || col_counts.get(&qc).unwrap_or(&0) > &0
                || diag_counts.get(&(qr - qc)).unwrap_or(&0) > &0
                || anti_diag_counts.get(&(qr + qc)).unwrap_or(&0) > &0;

            if illuminated {
                results.push(1);
            } else {
                results.push(0);
            }

            for dr in -1..=1 {
                for dc in -1..=1 {
                    let nr = qr + dr;
                    let nc = qc + dc;

                    if lamp_set.remove(&(nr, nc)) {
                        if let Some(count) = row_counts.get_mut(&nr) {
                            *count -= 1;
                            if *count == 0 {
                                row_counts.remove(&nr);
                            }
                        }
                        if let Some(count) = col_counts.get_mut(&nc) {
                            *count -= 1;
                            if *count == 0 {
                                col_counts.remove(&nc);
                            }
                        }
                        if let Some(count) = diag_counts.get_mut(&(nr - nc)) {
                            *count -= 1;
                            if *count == 0 {
                                diag_counts.remove(&(nr - nc));
                            }
                        }
                        if let Some(count) = anti_diag_counts.get_mut(&(nr + nc)) {
                            *count -= 1;
                            if *count == 0 {
                                anti_diag_counts.remove(&(nr + nc));
                            }
                        }
                    }
                }
            }
        }

        results
    }
}