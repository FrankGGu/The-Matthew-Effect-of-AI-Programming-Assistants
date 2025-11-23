impl Solution {
    pub fn whack_a_mole(moles: Vec<Vec<i32>>) -> i32 {
        if moles.is_empty() {
            return 0;
        }

        let mut sorted_moles = moles;
        sorted_moles.sort_unstable_by(|a, b| {
            a[0].cmp(&b[0]).then_with(|| a[1].cmp(&b[1]))
        });

        let n = sorted_moles.len();
        let mut dp = vec![0; n];
        let mut max_moles_hit = 0;

        for i in 0..n {
            let current_mole_time = sorted_moles[i][0];
            let current_mole_pos = sorted_moles[i][1];

            if current_mole_pos.abs() <= current_mole_time {
                dp[i] = 1;
            } else {
                dp[i] = 0;
            }

            for j in 0..i {
                let prev_mole_time = sorted_moles[j][0];
                let prev_mole_pos = sorted_moles[j][1];

                if dp[j] > 0 {
                    let time_diff = current_mole_time - prev_mole_time;
                    let pos_diff = (current_mole_pos - prev_mole_pos).abs();

                    if pos_diff <= time_diff {
                        dp[i] = dp[i].max(dp[j] + 1);
                    }
                }
            }
            max_moles_hit = max_moles_hit.max(dp[i]);
        }

        max_moles_hit
    }
}