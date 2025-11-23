impl Solution {
    pub fn push_dominoes(dominoes: String) -> String {
        let mut dominoes: Vec<char> = dominoes.chars().collect();
        let n = dominoes.len();
        let mut forces = vec![0; n];

        let mut force = 0;
        for i in 0..n {
            if dominoes[i] == 'R' {
                force = n;
            } else if dominoes[i] == 'L' {
                force = 0;
            } else {
                force = std::cmp::max(force - 1, 0);
            }
            forces[i] += force;
        }

        force = 0;
        for i in (0..n).rev() {
            if dominoes[i] == 'L' {
                force = n;
            } else if dominoes[i] == 'R' {
                force = 0;
            } else {
                force = std::cmp::max(force - 1, 0);
            }
            forces[i] -= force;
        }

        let mut result = String::new();
        for &f in &forces {
            if f > 0 {
                result.push('R');
            } else if f < 0 {
                result.push('L');
            } else {
                result.push('.');
            }
        }

        result
    }
}