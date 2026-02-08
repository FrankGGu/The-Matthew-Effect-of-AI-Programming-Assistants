use std::collections::HashSet;

impl Solution {
    pub fn num_tile_possibilities(tiles: String) -> i32 {
        let mut tiles_vec: Vec<char> = tiles.chars().collect();
        tiles_vec.sort();
        let mut used = vec![false; tiles_vec.len()];
        let mut res = HashSet::new();

        fn backtrack(tiles: &Vec<char>, used: &mut Vec<bool>, current: String, res: &mut HashSet<String>) {
            if !current.is_empty() {
                res.insert(current.clone());
            }

            for i in 0..tiles.len() {
                if used[i] || (i > 0 && tiles[i] == tiles[i - 1] && !used[i - 1]) {
                    continue;
                }

                used[i] = true;
                backtrack(tiles, used, current.clone() + &tiles[i].to_string(), res);
                used[i] = false;
            }
        }

        backtrack(&tiles_vec, &mut used, String::new(), &mut res);

        res.len() as i32
    }
}