impl Solution {
    pub fn stone_game_ix(stones: Vec<i32>) -> bool {
        let mut count = [0; 3];
        for &stone in &stones {
            count[(stone % 3) as usize] += 1;
        }

        let (a, b, c) = (count[0], count[1], count[2]);

        if a == 0 {
            return b > c;
        }
        if a == 1 {
            return b > c || c == 0;
        }
        if b == 0 {
            return a > c;
        }
        if c == 0 {
            return b > a;
        }
        a > c
    }
}