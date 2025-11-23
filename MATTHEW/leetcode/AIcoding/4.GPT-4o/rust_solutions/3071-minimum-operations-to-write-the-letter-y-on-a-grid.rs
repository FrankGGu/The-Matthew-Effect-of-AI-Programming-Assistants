impl Solution {
    pub fn minimum_operations(grid: Vec<Vec<i32>>, letter: char) -> i32 {
        let mut count = 0;
        let target = letter as i32 - 'a' as i32;
        for row in grid.iter() {
            for &cell in row.iter() {
                if cell == target {
                    count += 1;
                }
            }
        }
        if count == 0 {
            return -1;
        }
        count
    }
}