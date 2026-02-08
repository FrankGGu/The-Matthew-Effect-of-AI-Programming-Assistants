impl Solution {
    pub fn push_dominoes(dominoes: String) -> String {
        let n = dominoes.len();
        let mut forces = vec![0; n];
        let chars: Vec<char> = dominoes.chars().collect();

        // Pass 1: Calculate rightward forces
        // A rightward force starts strong (value 'n') at an 'R' and diminishes by 1 for each '.'
        // It is reset to 0 by an 'L' (as 'L' stops rightward propagation)
        let mut f = 0;
        for i in 0..n {
            match chars[i] {
                'R' => f = n as i32,
                'L' => f = 0,
                '.' => {
                    if f > 0 {
                        f -= 1;
                    }
                }
                _ => {} // Should not happen based on problem constraints
            }
            forces[i] += f;
        }

        // Pass 2: Calculate leftward forces
        // A leftward force starts strong (value 'n') at an 'L' and diminishes by 1 for each '.'
        // It is reset to 0 by an 'R' (as 'R' stops leftward propagation)
        // We subtract these forces because they push in the opposite direction
        f = 0;
        for i in (0..n).rev() {
            match chars[i] {
                'L' => f = n as i32,
                'R' => f = 0,
                '.' => {
                    if f > 0 {
                        f -= 1;
                    }
                }
                _ => {} // Should not happen
            }
            forces[i] -= f;
        }

        // Determine the final state of each domino based on the net force
        let mut result_chars: Vec<char> = Vec::with_capacity(n);
        for i in 0..n {
            if forces[i] > 0 {
                result_chars.push('R');
            } else if forces[i] < 0 {
                result_chars.push('L');
            } else {
                result_chars.push('.');
            }
        }

        result_chars.into_iter().collect()
    }
}