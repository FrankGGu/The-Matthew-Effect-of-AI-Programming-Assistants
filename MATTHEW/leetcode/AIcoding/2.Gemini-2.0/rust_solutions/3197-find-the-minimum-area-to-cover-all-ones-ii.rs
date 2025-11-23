use std::cmp::{max, min};

impl Solution {
    pub fn min_area_rect(mat: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut ones = Vec::new();
        for i in 0..m {
            for j in 0..n {
                if mat[i][j] == 1 {
                    ones.push((i as i32, j as i32));
                }
            }
        }
        let num_ones = ones.len();
        if num_ones == 0 {
            return 0;
        }

        let mut min_area = i32::MAX;
        for i in 0..num_ones {
            for j in i + 1..num_ones {
                let x1 = ones[i].0;
                let y1 = ones[i].1;
                let x2 = ones[j].0;
                let y2 = ones[j].1;

                let left = min(x1, x2);
                let right = max(x1, x2);
                let top = min(y1, y2);
                let bottom = max(y1, y2);

                let width = right - left + 1;
                let height = bottom - top + 1;
                let area = width * height;

                let mut covered_ones = 0;
                for l in 0..num_ones {
                    let x = ones[l].0;
                    let y = ones[l].1;
                    if x >= left && x <= right && y >= top && y <= bottom {
                        covered_ones += 1;
                    }
                }

                if covered_ones >= k {
                    min_area = min(min_area, area);
                }
            }
        }

        if min_area == i32::MAX {
            return -1;
        } else {
            return min_area;
        }
    }
}