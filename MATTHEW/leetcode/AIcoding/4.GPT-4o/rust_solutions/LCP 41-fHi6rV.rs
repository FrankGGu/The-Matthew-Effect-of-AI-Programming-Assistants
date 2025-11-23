impl Solution {
    pub fn flip_chess(chessboard: Vec<String>) -> i32 {
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0), (1, 1), (1, -1), (-1, 1), (-1, -1)];
        let mut max_flips = 0;

        for i in 0..8 {
            for j in 0..8 {
                if chessboard[i].chars().nth(j) == Some('.') {
                    let mut flip_count = 0;
                    for &(dx, dy) in &directions {
                        let mut x = i as isize;
                        let mut y = j as isize;
                        let mut temp_count = 0;
                        while x >= 0 && x < 8 && y >= 0 && y < 8 {
                            match chessboard[x as usize].chars().nth(y as usize) {
                                Some('O') => {
                                    temp_count += 1;
                                },
                                Some('X') => {
                                    flip_count += temp_count;
                                    break;
                                },
                                _ => break,
                            }
                            x += dx;
                            y += dy;
                        }
                    }
                    max_flips = max_flips.max(flip_count);
                }
            }
        }

        max_flips
    }
}