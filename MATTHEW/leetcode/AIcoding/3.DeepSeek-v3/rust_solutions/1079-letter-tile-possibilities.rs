use std::collections::HashSet;

impl Solution {
    pub fn num_tile_possibilities(tiles: String) -> i32 {
        let mut count = [0; 26];
        for c in tiles.chars() {
            count[(c as u8 - b'A') as usize] += 1;
        }
        let mut result = 0;
        Solution::backtrack(&mut count, &mut result);
        result
    }

    fn backtrack(count: &mut [i32; 26], result: &mut i32) {
        for i in 0..26 {
            if count[i] == 0 {
                continue;
            }
            count[i] -= 1;
            *result += 1;
            Solution::backtrack(count, result);
            count[i] += 1;
        }
    }
}