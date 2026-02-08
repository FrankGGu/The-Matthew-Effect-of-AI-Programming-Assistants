impl Solution {
    pub fn count_artifacts(n: i32, artifacts: Vec<Vec<i32>>, dig: Vec<Vec<i32>>) -> i32 {
        let n_usize = n as usize;
        let mut dug_grid = vec![vec![false; n_usize]; n_usize];

        for d in dig {
            let r = d[0] as usize;
            let c = d[1] as usize;
            dug_grid[r][c] = true;
        }

        let mut extracted_count = 0;

        for artifact in artifacts {
            let r1 = artifact[0] as usize;
            let c1 = artifact[1] as usize;
            let r2 = artifact[2] as usize;
            let c2 = artifact[3] as usize;

            let mut can_extract = true;
            'artifact_cell_check: for r in r1..=r2 {
                for c in c1..=c2 {
                    if !dug_grid[r][c] {
                        can_extract = false;
                        break 'artifact_cell_check;
                    }
                }
            }

            if can_extract {
                extracted_count += 1;
            }
        }

        extracted_count
    }
}