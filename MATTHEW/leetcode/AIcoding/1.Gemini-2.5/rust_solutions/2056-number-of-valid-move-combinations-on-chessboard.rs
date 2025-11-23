use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn number_of_valid_move_combinations(pieces: Vec<String>, positions: Vec<Vec<i32>>) -> i32 {
        let n = pieces.len();
        let mut all_possible_moves: Vec<Vec<(usize, usize)>> = Vec::with_capacity(n);

        for i in 0..n {
            let piece_type = &pieces[i];
            let start_r = positions[i][0] as usize;
            let start_c = positions[i][1] as usize;
            let mut moves_for_piece = Vec::new();

            let dr = [-1, -1, -1, 0, 0, 1, 1, 1];
            let dc = [-1, 0, 1, -1, 1, -1, 0, 1];

            for k in 0..8 {
                let (dir_r, dir_c) = (dr[k], dc[k]);

                let is_rook_dir = dir_r == 0 || dir_c == 0;
                let is_bishop_dir = dir_r != 0 && dir_c != 0;

                let can_move_in_dir = match piece_type.as_str() {
                    "rook" => is_rook_dir,
                    "bishop" => is_bishop_dir,
                    "queen" => true,
                    _ => false,
                };

                if can_move_in_dir {
                    for step in 1..8 {
                        let new_r_isize = start_r as isize + step * dir_r;
                        let new_c_isize = start_c as isize + step * dir_c;

                        if new_r_isize >= 0 && new_r_isize < 8 && new_c_isize >= 0 && new_c_isize < 8 {
                            moves_for_piece.push((new_r_isize as usize, new_c_isize as usize));
                        } else {
                            break;
                        }
                    }
                }
            }
            all_possible_moves.push(moves_for_piece);
        }

        let mut count = 0;
        let mut occupied_squares: HashSet<(usize, usize)> = HashSet::new();

        Self::backtrack(0, n, &all_possible_moves, &mut occupied_squares, &mut count);

        count
    }

    fn backtrack(
        piece_idx: usize,
        num_pieces: usize,
        all_possible_moves: &Vec<Vec<(usize, usize)>>,
        occupied_squares: &mut HashSet<(usize, usize)>,
        count: &mut i32,
    ) {
        if piece_idx == num_pieces {
            *count += 1;
            return;
        }

        for &next_dest in &all_possible_moves[piece_idx] {
            if !occupied_squares.contains(&next_dest) {
                occupied_squares.insert(next_dest);
                Self::backtrack(piece_idx + 1, num_pieces, all_possible_moves, occupied_squares, count);
                occupied_squares.remove(&next_dest);
            }
        }
    }
}