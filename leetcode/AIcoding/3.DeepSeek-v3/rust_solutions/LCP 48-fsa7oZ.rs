use std::collections::HashSet;

struct InfiniteGame {
    black: HashSet<(i32, i32)>,
    white: HashSet<(i32, i32)>,
}

impl InfiniteGame {
    fn new() -> Self {
        InfiniteGame {
            black: HashSet::new(),
            white: HashSet::new(),
        }
    }

    fn play(&mut self, x: i32, y: i32, color: i32) -> bool {
        let stones = if color == 1 { &mut self.black } else { &mut self.white };
        let opponent_stones = if color == 1 { &self.white } else { &self.black };
        stones.insert((x, y));

        let directions = [(0, 1), (1, 0), (1, 1), (1, -1)];

        for &(dx, dy) in &directions {
            let mut count = 1;

            let (mut nx, mut ny) = (x + dx, y + dy);
            while stones.contains(&(nx, ny)) {
                count += 1;
                nx += dx;
                ny += dy;
            }

            let (mut px, mut py) = (x - dx, y - dy);
            while stones.contains(&(px, py)) {
                count += 1;
                px -= dx;
                py -= dy;
            }

            if count >= 5 {
                return true;
            }
        }

        false
    }
}

struct Solution;

impl Solution {
    pub fn judge_winner(moves: Vec<Vec<i32>>) -> String {
        let mut game = InfiniteGame::new();
        for (i, m) in moves.iter().enumerate() {
            let x = m[0];
            let y = m[1];
            let color = if i % 2 == 0 { 1 } else { 2 };
            if game.play(x, y, color) {
                return if color == 1 { "Black".to_string() } else { "White".to_string() };
            }
        }
        "Draw".to_string()
    }
}