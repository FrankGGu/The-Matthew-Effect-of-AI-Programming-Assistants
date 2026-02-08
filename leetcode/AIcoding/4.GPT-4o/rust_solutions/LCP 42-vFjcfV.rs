impl Solution {
    pub fn num_rings(rings: String) -> i32 {
        let mut counts = vec![0; 10];
        let mut seen = std::collections::HashSet::new();

        let chars: Vec<_> = rings.chars().collect();
        for i in (0..rings.len()).step_by(2) {
            let color = chars[i];
            let position = chars[i + 1].to_digit(10).unwrap() as usize;
            let index = match color {
                'R' => 0,
                'G' => 1,
                'B' => 2,
                _ => continue,
            };
            seen.insert(position);
            counts[position] |= 1 << index;
        }

        counts.iter().filter(|&&c| c == 0b111).count() as i32
    }
}