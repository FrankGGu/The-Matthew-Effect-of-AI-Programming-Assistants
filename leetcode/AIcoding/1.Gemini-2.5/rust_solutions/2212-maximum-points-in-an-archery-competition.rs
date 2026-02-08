struct Solution;

impl Solution {
    pub fn maximum_points(num_arrows: i32, bob_arrows: Vec<i32>) -> Vec<i32> {
        let mut max_score = -1;
        let mut best_alice_arrows: Vec<i32> = vec![0; 12];

        let mut current_alice_arrows: Vec<i32> = vec![0; 12];

        fn backtrack(
            segment_idx: usize,
            arrows_left: i32,
            current_score: i32,
            bob_arrows: &[i32],
            current_alice_arrows: &mut Vec<i32>,
            max_score: &mut i32,
            best_alice_arrows: &mut Vec<i32>,
        ) {
            if segment_idx == 12 {
                if current_score > *max_score {
                    *max_score = current_score;
                    let mut final_alice_arrows = current_alice_arrows.clone();
                    final_alice_arrows[0] += arrows_left;
                    *best_alice_arrows = final_alice_arrows;
                }
                return;
            }

            current_alice_arrows[segment_idx] = 0;
            backtrack(
                segment_idx + 1,
                arrows_left,
                current_score,
                bob_arrows,
                current_alice_arrows,
                max_score,
                best_alice_arrows,
            );

            let arrows_needed = bob_arrows[segment_idx] + 1;
            if arrows_left >= arrows_needed {
                current_alice_arrows[segment_idx] = arrows_needed;
                backtrack(
                    segment_idx + 1,
                    arrows_left - arrows_needed,
                    current_score + segment_idx as i32,
                    bob_arrows,
                    current_alice_arrows,
                    max_score,
                    best_alice_arrows,
                );
                current_alice_arrows[segment_idx] = 0;
            }
        }

        backtrack(
            0,
            num_arrows,
            0,
            &bob_arrows,
            &mut current_alice_arrows,
            &mut max_score,
            &mut best_alice_arrows,
        );

        best_alice_arrows
    }
}