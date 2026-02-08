pub fn count_black_blocks(m: i32, n: i32, coordinates: Vec<Vec<i32>>, side_length: i32) -> Vec<i32> {
    let mut grid = vec![vec![0; n as usize]; m as usize];
    let mut count = vec![0; 4];

    for coord in coordinates {
        let (x, y) = (coord[0] as usize, coord[1] as usize);
        for dx in 0..side_length {
            for dy in 0..side_length {
                let nx = x + dx as usize;
                let ny = y + dy as usize;
                if nx < m as usize && ny < n as usize {
                    grid[nx][ny] += 1;
                }
            }
        }
    }

    let mut block_set = std::collections::HashSet::new();

    for i in 0..m as usize {
        for j in 0..n as usize {
            if grid[i][j] > 0 {
                let block_x = i / side_length as usize;
                let block_y = j / side_length as usize;
                block_set.insert((block_x, block_y));
            }
        }
    }

    for (bx, by) in block_set {
        count[(bx * side_length as usize + by) as usize] += 1;
    }

    count
}