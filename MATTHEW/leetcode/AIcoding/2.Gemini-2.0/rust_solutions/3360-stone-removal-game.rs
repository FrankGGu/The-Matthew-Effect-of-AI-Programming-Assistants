impl Solution {
    pub fn stone_game_ix(stones: Vec<i32>) -> bool {
        let mut mods = [0; 3];
        for &stone in &stones {
            mods[(stone % 3) as usize] += 1;
        }

        if mods[0] % 2 == 0 {
            return mods[1] > 0 && mods[2] > 0;
        } else {
            return (mods[1] - mods[2]).abs() > 2;
        }
    }
}