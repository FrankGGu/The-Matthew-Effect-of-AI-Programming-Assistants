impl Solution {
    pub fn push_dominoes(dominoes: String) -> String {
        let mut dominoes = dominoes.into_bytes();
        let n = dominoes.len();
        let mut forces = vec![0; n];
        let mut force = 0;

        for i in 0..n {
            match dominoes[i] {
                b'R' => force = n as i32,
                b'L' => force = 0,
                _ => force = std::cmp::max(force - 1, 0),
            }
            forces[i] += force;
        }

        force = 0;
        for i in (0..n).rev() {
            match dominoes[i] {
                b'L' => force = n as i32,
                b'R' => force = 0,
                _ => force = std::cmp::max(force - 1, 0),
            }
            forces[i] -= force;
        }

        for i in 0..n {
            dominoes[i] = match forces[i] {
                x if x > 0 => b'R',
                x if x < 0 => b'L',
                _ => b'.',
            };
        }

        String::from_utf8(dominoes).unwrap()
    }
}