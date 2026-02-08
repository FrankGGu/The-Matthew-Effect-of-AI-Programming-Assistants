use std::collections::HashSet;

impl Solution {
    pub fn traffic_command(commands: Vec<String>) -> i32 {
        let mut dp = HashSet::new();
        let initial_state = [0, 0, 0, 0];
        dp.insert(initial_state);
        let mut time = 0;

        while !dp.is_empty() {
            let mut next_dp = HashSet::new();
            for state in dp.iter() {
                if state[0] == commands[0].len() && state[1] == commands[1].len() && 
                   state[2] == commands[2].len() && state[3] == commands[3].len() {
                    return time;
                }
                for mask in 1..16 {
                    let mut new_state = *state;
                    let mut valid = true;
                    let mut moving = [false; 4];
                    for i in 0..4 {
                        if (mask & (1 << i)) != 0 {
                            if new_state[i] >= commands[i].len() {
                                valid = false;
                                break;
                            }
                            moving[i] = true;
                        }
                    }
                    if !valid {
                        continue;
                    }
                    for i in 0..4 {
                        for j in i+1..4 {
                            if moving[i] && moving[j] {
                                let a = commands[i].as_bytes()[state[i]] as char;
                                let b = commands[j].as_bytes()[state[j]] as char;
                                if !Self::can_move(a, b, i, j) {
                                    valid = false;
                                    break;
                                }
                            }
                        }
                        if !valid {
                            break;
                        }
                    }
                    if valid {
                        for i in 0..4 {
                            if moving[i] {
                                new_state[i] += 1;
                            }
                        }
                        next_dp.insert(new_state);
                    }
                }
            }
            dp = next_dp;
            time += 1;
        }
        -1
    }

    fn can_move(a: char, b: char, i: usize, j: usize) -> bool {
        let dirs = ['N', 'S', 'W', 'E'];
        let (di, dj) = (dirs[i], dirs[j]);
        match (di, dj) {
            ('N', 'S') | ('S', 'N') | ('W', 'E') | ('E', 'W') => a != b,
            ('N', 'E') | ('E', 'N') => a != 'S' && a != 'W' && b != 'S' && b != 'W',
            ('N', 'W') | ('W', 'N') => a != 'S' && a != 'E' && b != 'S' && b != 'E',
            ('S', 'E') | ('E', 'S') => a != 'N' && a != 'W' && b != 'N' && b != 'W',
            ('S', 'W') | ('W', 'S') => a != 'N' && a != 'E' && b != 'N' && b != 'E',
            _ => true,
        }
    }
}