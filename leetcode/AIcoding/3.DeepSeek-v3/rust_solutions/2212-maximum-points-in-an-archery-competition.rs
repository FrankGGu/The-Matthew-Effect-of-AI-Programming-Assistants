impl Solution {
    pub fn maximum_bob_points(num_arrows: i32, alice_arrows: Vec<i32>) -> Vec<i32> {
        let mut max_points = 0;
        let mut best_bob_arrows = vec![0; 12];

        for mask in 0..(1 << 12) {
            let mut points = 0;
            let mut arrows_used = 0;
            let mut bob_arrows = vec![0; 12];

            for i in 0..12 {
                if mask & (1 << i) != 0 {
                    points += i;
                    bob_arrows[i] = alice_arrows[i] + 1;
                    arrows_used += bob_arrows[i];
                }
            }

            if arrows_used <= num_arrows && points > max_points {
                max_points = points;
                best_bob_arrows = bob_arrows.clone();
                if arrows_used < num_arrows {
                    best_bob_arrows[0] += num_arrows - arrows_used;
                }
            }
        }

        best_bob_arrows
    }
}