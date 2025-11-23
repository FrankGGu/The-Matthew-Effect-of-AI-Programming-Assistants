pub fn check_knight_tour(configuration: Vec<Vec<i32>>) -> bool {
    let directions = vec![
        (2, 1), (2, -1), (-2, 1), (-2, -1),
        (1, 2), (1, -2), (-1, 2), (-1, -2),
    ];
    let n = configuration.len();
    let mut visited = vec![vec![false; n]; n];
    let mut position = vec![(0, 0); n * n];

    for i in 0..n {
        for j in 0..n {
            position[configuration[i][j] as usize] = (i, j);
        }
    }

    for i in 0..n * n - 1 {
        let (x1, y1) = position[i];
        let (x2, y2) = position[i + 1];
        let valid_move = directions.iter().any(|&(dx, dy)| x1 + dx == x2 && y1 + dy == y2);
        if !valid_move {
            return false;
        }
    }

    true
}