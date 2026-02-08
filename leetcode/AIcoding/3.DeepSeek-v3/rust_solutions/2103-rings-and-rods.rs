impl Solution {
    pub fn count_points(rings: String) -> i32 {
        let mut rods = vec![0; 10];
        let rings_chars: Vec<char> = rings.chars().collect();

        for i in (0..rings_chars.len()).step_by(2) {
            let color = rings_chars[i];
            let rod = rings_chars[i + 1].to_digit(10).unwrap() as usize;

            match color {
                'R' => rods[rod] |= 1,
                'G' => rods[rod] |= 2,
                'B' => rods[rod] |= 4,
                _ => (),
            }
        }

        rods.iter().filter(|&&x| x == 7).count() as i32
    }
}