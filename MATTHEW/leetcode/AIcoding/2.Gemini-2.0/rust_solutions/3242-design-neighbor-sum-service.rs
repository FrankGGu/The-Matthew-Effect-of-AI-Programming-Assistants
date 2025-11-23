struct NeighborSum {
    grid: Vec<Vec<i32>>,
}

impl NeighborSum {
    fn new(grid: Vec<Vec<i32>>) -> Self {
        NeighborSum { grid }
    }

    fn update(&mut self, row: i32, col: i32, val: i32) {
        self.grid[row as usize][col as usize] = val;
    }

    fn get_neighbor_sum(&self, row: i32, col: i32) -> i32 {
        let mut sum = 0;
        let rows = self.grid.len() as i32;
        let cols = self.grid[0].len() as i32;

        for i in row - 1..=row + 1 {
            for j in col - 1..=col + 1 {
                if i >= 0 && i < rows && j >= 0 && j < cols {
                    sum += self.grid[i as usize][j as usize];
                }
            }
        }

        sum
    }
}