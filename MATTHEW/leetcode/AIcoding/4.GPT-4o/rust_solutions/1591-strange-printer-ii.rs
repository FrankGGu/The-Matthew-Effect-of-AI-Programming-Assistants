pub fn is_printable(printer: Vec<Vec<char>>) -> bool {
    let mut color_to_char = vec![vec![]; 128];
    let mut visited = vec![false; 128];

    for i in 0..printer.len() {
        for j in 0..printer[i].len() {
            if printer[i][j] != ' ' {
                color_to_char[printer[i][j] as usize].push((i, j));
            }
        }
    }

    fn dfs(c: char, color_to_char: &mut Vec<Vec<(usize, usize)>>, visited: &mut Vec<bool>) -> bool {
        let idx = c as usize;
        if visited[idx] {
            return true;
        }
        visited[idx] = true;

        let positions = color_to_char[idx].clone();
        for &(x, y) in &positions {
            for dx in -1..=1 {
                for dy in -1..=1 {
                    if (dx == 0 && dy == 0) || (dx.abs() + dy.abs() != 1) {
                        continue;
                    }
                    let nx = (x as isize + dx) as usize;
                    let ny = (y as isize + dy) as usize;
                    if nx < color_to_char.len() && ny < color_to_char[nx].len() {
                        if printer[nx][ny] != ' ' && printer[nx][ny] != c {
                            if !dfs(printer[nx][ny], color_to_char, visited) {
                                return false;
                            }
                        }
                    }
                }
            }
        }
        true
    }

    for c in 0..128 {
        if !visited[c] && !color_to_char[c].is_empty() {
            if !dfs(c as u8 as char, &mut color_to_char, &mut visited) {
                return false;
            }
        }
    }

    true
}