impl Solution {
    pub fn min_swaps_couples(mut row: Vec<i32>) -> i32 {
        let n = row.len();
        let mut pos: Vec<usize> = vec![0; n];

        for i in 0..n {
            pos[row[i] as usize] = i;
        }

        let mut swaps = 0;

        for i in (0..n).step_by(2) {
            let person1 = row[i];
            let partner_val = person1 ^ 1;

            let person2_at_i_plus_1 = row[i + 1];

            if person2_at_i_plus_1 != partner_val {
                swaps += 1;

                let partner_current_idx = pos[partner_val as usize];

                let val_to_move_from_i_plus_1 = row[i + 1];

                row[i + 1] = partner_val;
                row[partner_current_idx] = val_to_move_from_i_plus_1;

                pos[partner_val as usize] = i + 1;
                pos[val_to_move_from_i_plus_1 as usize] = partner_current_idx;
            }
        }

        swaps
    }
}