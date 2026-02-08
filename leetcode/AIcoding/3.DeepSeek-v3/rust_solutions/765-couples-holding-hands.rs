impl Solution {
    pub fn min_swaps_couples(row: Vec<i32>) -> i32 {
        let mut row = row;
        let mut swaps = 0;
        let n = row.len();
        let mut pos = vec![0; n];

        for (i, &num) in row.iter().enumerate() {
            pos[num as usize] = i;
        }

        for i in (0..n).step_by(2) {
            let x = row[i];
            let y = if x % 2 == 0 { x + 1 } else { x - 1 };

            if row[i + 1] != y {
                let j = pos[y as usize];
                row.swap(i + 1, j);
                pos[row[i + 1] as usize] = i + 1;
                pos[row[j] as usize] = j;
                swaps += 1;
            }
        }

        swaps
    }
}