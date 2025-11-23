impl Solution {
    pub fn odd_cells(n: i32, m: i32, indices: Vec<Vec<i32>>) -> i32 {
        let mut matrix = vec![vec![0; m as usize]; n as usize];
        for index in &indices {
            let row = index[0] as usize;
            let col = index[1] as usize;
            for j in 0..m as usize {
                matrix[row][j] += 1;
            }
            for i in 0..n as usize {
                matrix[i][col] += 1;
            }
        }
        let mut count = 0;
        for i in 0..n as usize {
            for j in 0..m as usize {
                if matrix[i][j] % 2 != 0 {
                    count += 1;
                }
            }
        }
        count
    }
}