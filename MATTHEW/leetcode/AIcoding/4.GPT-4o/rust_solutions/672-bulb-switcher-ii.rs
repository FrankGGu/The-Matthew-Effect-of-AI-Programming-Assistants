impl Solution {
    pub fn flip_lights(n: i32, presses: i32) -> i32 {
        if n == 0 { return 0; }
        let mut states = std::collections::HashSet::new();
        let max_presses = presses.min(4);

        for i in 0..1 << 4 {
            let press_count = i.count_ones();
            if press_count > max_presses { continue; }
            let mut bulbs = 0b0000_0000; // All bulbs off

            if i & 0b0001 != 0 { bulbs ^= 0b1111; } // toggle all
            if i & 0b0010 != 0 { bulbs ^= 0b1010; } // toggle odd
            if i & 0b0100 != 0 { bulbs ^= 0b0101; } // toggle even
            if i & 0b1000 != 0 { bulbs ^= 0b1111; } // toggle all

            let count = bulbs.count_ones();
            if n < count {
                states.insert(bulbs & ((1 << n) - 1));
            } else {
                states.insert(bulbs);
            }
        }
        states.len() as i32
    }
}