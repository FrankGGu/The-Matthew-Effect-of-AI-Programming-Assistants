pub fn min_distance(grid: Vec<Vec<i32>>) -> i32 {
    let n = grid.len();
    let m = grid[0].len();
    let (mut x_sum, mut y_sum) = (0, 0);
    let mut count = 0;

    for i in 0..n {
        for j in 0..m {
            if grid[i][j] == 1 {
                x_sum += i;
                y_sum += j;
                count += 1;
            }
        }
    }

    if count == 0 {
        return 0;
    }

    let x_avg = x_sum / count;
    let y_avg = y_sum / count;

    let mut distance = 0;
    for i in 0..n {
        for j in 0..m {
            if grid[i][j] == 1 {
                distance += (i - x_avg).abs() + (j - y_avg).abs();
            }
        }
    }

    distance
}