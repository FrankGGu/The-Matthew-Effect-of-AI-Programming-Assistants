impl Solution {
    pub fn find_champion(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        for i in 0..n {
            let mut is_champion = true;
            for j in 0..n {
                if i != j && grid[j][i] == 1 {
                    is_champion = false;
                    break;
                }
            }
            if is_champion {
                return i as i32;
            }
        }
        -1
    }
}