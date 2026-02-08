impl Solution {
    pub fn circular_game_losers(n: i32, k: i32) -> Vec<i32> {
        let mut received = vec![false; n as usize];
        let mut current = 0;
        let mut step = k;
        received[current] = true;

        while !received[((current as i32 + step) % n) as usize] {
            current = ((current as i32 + step) % n) as usize;
            received[current] = true;
            step += k;
        }

        let mut losers = Vec::new();
        for i in 0..n as usize {
            if !received[i] {
                losers.push((i as i32) + 1);
            }
        }

        losers
    }
}