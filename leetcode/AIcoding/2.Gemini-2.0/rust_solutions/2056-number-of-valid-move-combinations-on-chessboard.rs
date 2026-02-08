impl Solution {
    pub fn number_of_valid_move_combinations(
        pieces: Vec<String>,
        positions: Vec<Vec<i32>>,
    ) -> i64 {
        let n = pieces.len();
        let mut ans = 0;

        for mask in 0..(1 << (3 * n)) {
            let mut directions: Vec<Vec<i32>> = vec![Vec::new(); n];
            let mut valid = true;

            for i in 0..n {
                let dir_idx = (mask >> (3 * i)) & 7;
                if dir_idx == 0 {
                    directions[i] = vec![0, 0];
                } else if dir_idx == 1 {
                    directions[i] = vec![0, 1];
                } else if dir_idx == 2 {
                    directions[i] = vec![0, -1];
                } else if dir_idx == 3 {
                    directions[i] = vec![1, 0];
                } else if dir_idx == 4 {
                    directions[i] = vec![-1, 0];
                } else if dir_idx == 5 {
                    directions[i] = vec![1, 1];
                } else if dir_idx == 6 {
                    directions[i] = vec![1, -1];
                } else {
                    directions[i] = vec![-1, -1];
                }
            }

            let mut steps = vec![0; n];
            let mut pos = positions.clone();
            let mut blocked = vec![false; n];

            let mut moved = true;
            while moved {
                moved = false;
                for i in 0..n {
                    if blocked[i] {
                        continue;
                    }

                    let dx = directions[i][0];
                    let dy = directions[i][1];

                    let mut next_x = pos[i][0] + dx;
                    let mut next_y = pos[i][1] + dy;

                    if next_x < 1 || next_x > 8 || next_y < 1 || next_y > 8 {
                        blocked[i] = true;
                        continue;
                    }

                    let mut collision = false;
                    for j in 0..n {
                        if i != j && pos[j][0] == next_x && pos[j][1] == next_y {
                            collision = true;
                            break;
                        }
                    }

                    if collision {
                        blocked[i] = true;
                        continue;
                    }

                    let mut king_blocked = false;
                    if pieces[i] == "king" {
                        for j in 0..n {
                            if i != j {
                                let dx2 = (pos[j][0] - next_x).abs();
                                let dy2 = (pos[j][1] - next_y).abs();
                                if dx2 <= 1 && dy2 <= 1 {
                                    king_blocked = true;
                                    break;
                                }
                            }
                        }
                        if king_blocked {
                            blocked[i] = true;
                            continue;
                        }
                    }

                    pos[i][0] = next_x;
                    pos[i][1] = next_y;
                    steps[i] += 1;
                    moved = true;

                    if pieces[i] == "rook" && (dx.abs() + dy.abs()) > 1 {
                        valid = false;
                    }
                    if pieces[i] == "bishop" && dx.abs() != dy.abs() && (dx.abs() + dy.abs()) > 0 {
                        valid = false;
                    }

                    if pieces[i] == "queen" && (dx.abs() != dy.abs() && (dx.abs() + dy.abs()) != 1 && dx != 0 && dy != 0)
                    {
                        valid = false;
                    }

                    if pieces[i] == "king" && (dx.abs() > 1 || dy.abs() > 1)
                    {
                        valid = false;
                    }
                }
            }

            if valid {
                let all_blocked = blocked.iter().all(|&x| x);
                if all_blocked {
                    ans += 1;
                }
            }
        }

        ans
    }
}