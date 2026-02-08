impl Solution {
    pub fn count_points(rings: String) -> i32 {
        let mut rods = vec![0; 10];
        for i in (0..rings.len()).step_by(2) {
            let color = match rings.as_bytes()[i] {
                b'R' => 1,
                b'G' => 2,
                b'B' => 4,
                _ => 0,
            };
            let rod = (rings.as_bytes()[i + 1] - b'0') as usize;
            rods[rod] |= color;
        }
        rods.iter().filter(|&&r| r == 7).count() as i32
    }
}