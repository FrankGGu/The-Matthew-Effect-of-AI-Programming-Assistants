impl Solution {
    pub fn number_of_alternating_groups(colors: Vec<i32>, k: i32) -> i32 {
        let n = colors.len();
        let k_usize = k as usize;

        if k_usize > n {
            return 0;
        }
        if k_usize == 1 {
            return n as i32;
        }

        let mut extended_colors = Vec::with_capacity(n + k_usize - 1);
        extended_colors.extend_from_slice(&colors);
        extended_colors.extend_from_slice(&colors[0..k_usize - 1]);

        let mut is_bad = vec![0; n + k_usize - 2];
        for i in 0..n + k_usize - 2 {
            if extended_colors[i] == extended_colors[i+1] {
                is_bad[i] = 1;
            }
        }

        let mut prefix_sum_bad = vec![0; n + k_usize - 1];
        for i in 0..n + k_usize - 2 {
            prefix_sum_bad[i+1] = prefix_sum_bad[i] + is_bad[i];
        }

        let mut count = 0;
        for i in 0..n {
            let num_bad_pairs = prefix_sum_bad[i + k_usize - 1] - prefix_sum_bad[i];
            if num_bad_pairs == 0 {
                count += 1;
            }
        }

        count
    }
}