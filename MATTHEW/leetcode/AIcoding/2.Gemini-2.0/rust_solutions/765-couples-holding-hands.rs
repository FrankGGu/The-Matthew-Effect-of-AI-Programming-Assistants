impl Solution {
    pub fn min_swaps_couples(row: Vec<i32>) -> i32 {
        let n = row.len();
        let mut ans = 0;
        let mut pos = vec![0; n];
        for i in 0..n {
            pos[row[i] as usize] = i;
        }

        for i in (0..n).step_by(2) {
            let a = row[i];
            let b = if a % 2 == 0 { a + 1 } else { a - 1 };
            if row[i + 1] != b {
                let idx = pos[b as usize];
                row.swap(i + 1, idx);
                pos[row[i + 1] as usize] = i + 1;
                pos[row[idx] as usize] = idx;
                ans += 1;
            }
        }

        ans
    }
}