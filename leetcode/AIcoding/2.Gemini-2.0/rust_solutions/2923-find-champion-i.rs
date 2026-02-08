impl Solution {
    pub fn find_champion(adjacent_matrix: Vec<Vec<i32>>) -> i32 {
        let n = adjacent_matrix.len();
        for i in 0..n {
            let mut is_champion = true;
            for j in 0..n {
                if i != j && adjacent_matrix[i][j] == 0 {
                    is_champion = false;
                    break;
                }
            }
            if is_champion {
                return i as i32;
            }
        }
        0
    }
}