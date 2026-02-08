impl Solution {
    pub fn push_dominoes(dominoes: String) -> String {
        let mut s = dominoes.chars().collect::<Vec<_>>();
        let n = s.len();
        let mut forces = vec![0; n];

        let mut force = 0;
        for i in 0..n {
            if s[i] == 'R' {
                force = n; // A large positive force
            } else if s[i] == 'L' {
                force = 0;
            } else {
                force = force.saturating_sub(1);
            }
            forces[i] += force;
        }

        force = 0;
        for i in (0..n).rev() {
            if s[i] == 'L' {
                force = n; // A large negative force
            } else if s[i] == 'R' {
                force = 0;
            } else {
                force = force.saturating_sub(1);
            }
            forces[i] -= force;
        }

        for i in 0..n {
            if forces[i] > 0 {
                s[i] = 'R';
            } else if forces[i] < 0 {
                s[i] = 'L';
            } else {
                s[i] = '.';
            }
        }

        s.iter().collect()
    }
}