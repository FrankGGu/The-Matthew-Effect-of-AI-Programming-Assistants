use std::collections::{HashSet, HashMap};

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct Piece {
    x: i32,
    y: i32,
    dir: (i32, i32),
    steps: i32,
}

impl Piece {
    fn new(x: i32, y: i32, dir: (i32, i32), steps: i32) -> Self {
        Self { x, y, dir, steps }
    }
}

fn count_combinations(pieces: Vec<String>, positions: Vec<Vec<i32>>) -> i32 {
    let n = pieces.len();
    let mut directions = HashMap::new();
    directions.insert("rook".to_string(), vec![(1, 0), (-1, 0), (0, 1), (0, -1)]);
    directions.insert("queen".to_string(), vec![(1, 0), (-1, 0), (0, 1), (0, -1), (1, 1), (1, -1), (-1, 1), (-1, -1)]);
    directions.insert("bishop".to_string(), vec![(1, 1), (1, -1), (-1, 1), (-1, -1)]);

    let mut all_moves = Vec::new();
    for i in 0..n {
        let (x, y) = (positions[i][0], positions[i][1]);
        let piece_type = &pieces[i];
        let dirs = directions.get(piece_type).unwrap();
        let mut moves = Vec::new();
        for &(dx, dy) in dirs {
            for steps in 1..=7 {
                let nx = x + dx * steps;
                let ny = y + dy * steps;
                if nx < 1 || nx > 8 || ny < 1 || ny > 8 {
                    break;
                }
                moves.push(Piece::new(x, y, (dx, dy), steps));
            }
        }
        moves.push(Piece::new(x, y, (0, 0), 0));
        all_moves.push(moves);
    }

    let mut count = 0;
    let mut current = Vec::new();
    backtrack(&all_moves, 0, &mut current, &mut count);
    count
}

fn backtrack(all_moves: &Vec<Vec<Piece>>, idx: usize, current: &mut Vec<Piece>, count: &mut i32) {
    if idx == all_moves.len() {
        if is_valid(current) {
            *count += 1;
        }
        return;
    }

    for &mv in &all_moves[idx] {
        current.push(mv);
        backtrack(all_moves, idx + 1, current, count);
        current.pop();
    }
}

fn is_valid(moves: &[Piece]) -> bool {
    let n = moves.len();
    let mut positions = Vec::new();
    for i in 0..n {
        let mv = moves[i];
        let (mut x, mut y) = (mv.x, mv.y);
        let (dx, dy) = mv.dir;
        let steps = mv.steps;
        if steps == 0 {
            positions.push((x, y, i));
            continue;
        }
        for step in 1..=steps {
            x = mv.x + dx * step;
            y = mv.y + dy * step;
            positions.push((x, y, i));
        }
    }

    positions.sort();
    for i in 1..positions.len() {
        let (x1, y1, t1) = positions[i - 1];
        let (x2, y2, t2) = positions[i];
        if x1 == x2 && y1 == y2 {
            if t1 == t2 {
                continue;
            } else {
                return false;
            }
        }
    }
    true
}