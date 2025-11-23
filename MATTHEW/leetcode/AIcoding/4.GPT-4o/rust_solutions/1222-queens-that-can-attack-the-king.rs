pub fn queens_attack_the_king(queens: Vec<Vec<i32>>, king: Vec<i32>) -> Vec<Vec<i32>> {
    let directions = vec![
        (-1, 0), (-1, -1), (-1, 1), 
        (0, -1), (0, 1), 
        (1, 0), (1, -1), (1, 1)
    ];

    let mut queens_set = std::collections::HashSet::new();
    for queen in queens {
        queens_set.insert((queen[0], queen[1]));
    }

    let mut result = Vec::new();

    for &(dx, dy) in &directions {
        let mut x = king[0];
        let mut y = king[1];

        while x >= 0 && x < 8 && y >= 0 && y < 8 {
            if queens_set.contains(&(x, y)) {
                result.push(vec![x, y]);
                break;
            }
            x += dx;
            y += dy;
        }
    }

    result
}