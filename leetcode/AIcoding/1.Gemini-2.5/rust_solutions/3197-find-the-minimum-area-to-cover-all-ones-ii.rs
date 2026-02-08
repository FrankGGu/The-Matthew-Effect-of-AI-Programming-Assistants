impl Solution {
    pub fn minimum_area(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut min_total_area = i32::MAX;

        let get_area_of_ones = |r1: usize, c1: usize, r2: usize, c2: usize| -> i32 {
            let mut min_r_one = rows;
            let mut max_r_one = 0;
            let mut min_c_one = cols;
            let mut max_c_one = 0;
            let mut found_one = false;

            for r in r1..=r2 {
                for c in c1..=c2 {
                    if grid[r][c] == 1 {
                        min_r_one = min_r_one.min(r);
                        max_r_one = max_r_one.max(r);
                        min_c_one = min_c_one.min(c);
                        max_c_one = max_c_one.max(c);
                        found_one = true;
                    }
                }
            }

            if !found_one {
                0
            } else {
                ((max_r_one - min_r_one + 1) * (max_c_one - min_c_one + 1)) as i32
            }
        };

        min_total_area = min_total_area.min(get_area_of_ones(0, 0, rows - 1, cols - 1));

        for r_split in 0..rows - 1 {
            let area = get_area_of_ones(0, 0, r_split, cols - 1)
                     + get_area_of_ones(r_split + 1, 0, rows - 1, cols - 1);
            min_total_area = min_total_area.min(area);
        }
        for c_split in 0..cols - 1 {
            let area = get_area_of_ones(0, 0, rows - 1, c_split)
                     + get_area_of_ones(0, c_split + 1, rows - 1, cols - 1);
            min_total_area = min_total_area.min(area);
        }

        for r_split1 in 0..rows - 2 {
            for r_split2 in (r_split1 + 1)..rows - 1 {
                let area = get_area_of_ones(0, 0, r_split1, cols - 1)
                         + get_area_of_ones(r_split1 + 1, 0, r_split2, cols - 1)
                         + get_area_of_ones(r_split2 + 1, 0, rows - 1, cols - 1);
                min_total_area = min_total_area.min(area);
            }
        }
        for c_split1 in 0..cols - 2 {
            for c_split2 in (c_split1 + 1)..cols - 1 {
                let area = get_area_of_ones(0, 0, rows - 1, c_split1)
                         + get_area_of_ones(0, c_split1 + 1, rows - 1, c_split2)
                         + get_area_of_ones(0, c_split2 + 1, rows - 1, cols - 1);
                min_total_area = min_total_area.min(area);
            }
        }

        for r_split in 0..rows - 1 {
            for c_split in 0..cols - 1 {
                let area = get_area_of_ones(0, 0, r_split, c_split)
                         + get_area_of_ones(0, c_split + 1, r_split, cols - 1)
                         + get_area_of_ones(r_split + 1, 0, rows - 1, cols - 1);
                min_total_area = min_total_area.min(area);
            }
            for c_split in 0..cols - 1 {
                let area = get_area_of_ones(0, 0, r_split, cols - 1)
                         + get_area_of_ones(r_split + 1, 0, rows - 1, c_split)
                         + get_area_of_ones(r_split + 1, c_split + 1, rows - 1, cols - 1);
                min_total_area = min_total_area.min(area);
            }
        }

        for c_split in 0..cols - 1 {
            for r_split in 0..rows - 1 {
                let area = get_area_of_ones(0, 0, r_split, c_split)
                         + get_area_of_ones(r_split + 1, 0, rows - 1, c_split)
                         + get_area_of_ones(0, c_split + 1, rows - 1, cols - 1);
                min_total_area = min_total_area.min(area);
            }
            for r_split in 0..rows - 1 {
                let area = get_area_of_ones(0, 0, rows - 1, c_split)
                         + get_area_of_ones(0, c_split + 1, r_split, cols - 1)
                         + get_area_of_ones(r_split + 1, c_split + 1, rows - 1, cols - 1);
                min_total_area = min_total_area.min(area);
            }
        }

        min_total_area
    }
}