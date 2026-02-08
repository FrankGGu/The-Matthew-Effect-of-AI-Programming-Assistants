impl Solution {
    pub fn count_cells(n: i32, m: i32, hs: Vec<i32>, vs: Vec<i32>) -> i32 {
        let mut h_count = vec![0; n as usize];
        let mut v_count = vec![0; m as usize];

        for &h in &hs {
            h_count[(h - 1) as usize] += 1;
        }

        for &v in &vs {
            v_count[(v - 1) as usize] += 1;
        }

        let mut h_overlap = 0;
        for &count in &h_count {
            if count > 0 {
                h_overlap += 1;
            }
        }

        let mut v_overlap = 0;
        for &count in &v_count {
            if count > 0 {
                v_overlap += 1;
            }
        }

        h_overlap * v_overlap
    }
}