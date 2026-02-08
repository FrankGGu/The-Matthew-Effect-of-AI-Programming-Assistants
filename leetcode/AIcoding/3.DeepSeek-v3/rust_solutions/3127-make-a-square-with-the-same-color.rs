impl Solution {
    pub fn can_make_square(grid: Vec<Vec<char>>) -> bool {
        for i in 0..2 {
            for j in 0..2 {
                let mut count_b = 0;
                let mut count_w = 0;
                for di in 0..2 {
                    for dj in 0..2 {
                        match grid[i + di][j + dj] {
                            'B' => count_b += 1,
                            'W' => count_w += 1,
                            _ => (),
                        }
                    }
                }
                if count_b >= 3 || count_w >= 3 {
                    return true;
                }
            }
        }
        false
    }
}