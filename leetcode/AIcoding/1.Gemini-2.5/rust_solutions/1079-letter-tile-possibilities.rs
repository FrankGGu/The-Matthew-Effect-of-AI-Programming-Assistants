struct Solution;

impl Solution {
    pub fn num_tile_possibilities(tiles: String) -> i32 {
        let mut counts = [0; 26];
        for c in tiles.chars() {
            counts[(c as u8 - b'A') as usize] += 1;
        }

        Self::backtrack(&mut counts)
    }

    fn backtrack(counts: &mut [i32; 26]) -> i32 {
        let mut result = 0;
        for i in 0..26 {
            if counts[i] > 0 {
                counts[i] -= 1;
                result += 1;
                result += Self::backtrack(counts);
                counts[i] += 1;
            }
        }
        result
    }
}