impl Solution {
    pub fn count_points(rings: String) -> i32 {
        let mut rods: [u8; 10] = [0; 10];

        let bytes = rings.as_bytes();
        for i in (0..bytes.len()).step_by(2) {
            let color_char = bytes[i] as char;
            let rod_char = bytes[i + 1] as char;

            let rod_idx = rod_char.to_digit(10).unwrap() as usize;
            let color_mask = match color_char {
                'R' => 1,
                'G' => 2,
                'B' => 4,
                _ => 0,
            };

            rods[rod_idx] |= color_mask;
        }

        let mut count = 0;
        for &rod_colors in rods.iter() {
            if rod_colors == 7 {
                count += 1;
            }
        }

        count
    }
}