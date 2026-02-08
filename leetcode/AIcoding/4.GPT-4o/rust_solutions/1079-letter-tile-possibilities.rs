impl Solution {
    pub fn num_tile_possibilities(tiles: String) -> i32 {
        let mut tiles: Vec<char> = tiles.chars().collect();
        tiles.sort();
        let mut result = 0;
        let mut used = vec![false; tiles.len()];
        Self::backtrack(&tiles, &mut used, &mut result);
        result
    }

    fn backtrack(tiles: &[char], used: &mut Vec<bool>, result: &mut i32) {
        for i in 0..tiles.len() {
            if used[i] { continue; }
            if i > 0 && tiles[i] == tiles[i - 1] && !used[i - 1] { continue; }
            used[i] = true;
            *result += 1;
            Self::backtrack(tiles, used, result);
            used[i] = false;
        }
    }
}