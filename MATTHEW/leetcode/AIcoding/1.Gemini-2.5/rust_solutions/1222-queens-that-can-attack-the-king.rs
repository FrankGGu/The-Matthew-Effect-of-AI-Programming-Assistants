use std::collections::HashSet;

impl Solution {
    pub fn queens_attack_the_king(queens: Vec<Vec<i32>>, king: Vec<i32>) -> Vec<Vec<i32>> {
        let mut queen_positions: HashSet<(i32, i32)> = HashSet::new();
        for q in queens {
            queen_positions.insert((q[0], q[1]));
        }

        let kx = king[0];
        let ky = king[1];

        let mut attacking_queens: Vec<Vec<i32>> = Vec::new();

        let directions = vec![
            (0, 1),
            (0, -1),
            (1, 0),
            (-1, 0),
            (1, 1),
            (1, -1),
            (-1, 1),
            (-1, -1),
        ];

        for (dx, dy) in directions {
            let mut current_x = kx + dx;
            let mut current_y = ky + dy;

            while current_x >= 0 && current_x < 8 && current_y >= 0 && current_y < 8 {
                if queen_positions.contains(&(current_x, current_y)) {
                    attacking_queens.push(vec![current_x, current_y]);
                    break;
                }
                current_x += dx;
                current_y += dy;
            }
        }

        attacking_queens
    }
}