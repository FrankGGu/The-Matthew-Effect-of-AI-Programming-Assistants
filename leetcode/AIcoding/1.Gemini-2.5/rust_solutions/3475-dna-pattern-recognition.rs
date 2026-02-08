use std::collections::HashSet;

impl Solution {
    pub fn find_repeated_dna_sequences(s: String) -> Vec<String> {
        if s.len() < 10 {
            return Vec::new();
        }

        let mut seen_int: HashSet<u32> = HashSet::new();
        let mut repeated_str: HashSet<String> = HashSet::new();

        let char_to_int = |c: u8| -> u32 {
            match c {
                b'A' => 0,
                b'C' => 1,
                b'G' => 2,
                b'T' => 3,
                _ => unreachable!(),
            }
        };

        let s_bytes = s.as_bytes();
        let mut current_hash: u32 = 0;
        const L: usize = 10;
        const MASK: u32 = (1 << (2 * L)) - 1;

        for i in 0..L {
            current_hash = (current_hash << 2) | char_to_int(s_bytes[i]);
        }

        seen_int.insert(current_hash);

        for i in 1..=(s.len() - L) {
            current_hash = (current_hash << 2) & MASK;
            current_hash |= char_to_int(s_bytes[i + L - 1]);

            if seen_int.contains(&current_hash) {
                repeated_str.insert(s[i..i + L].to_string());
            } else {
                seen_int.insert(current_hash);
            }
        }

        repeated_str.into_iter().collect()
    }
}