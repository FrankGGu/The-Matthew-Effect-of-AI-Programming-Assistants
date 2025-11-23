impl Solution {
    pub fn number_of_alternating_groups(colors: Vec<i32>, k: i32) -> i32 {
        let n = colors.len();
        let k_usize = k as usize;

        let mut is_alternating: Vec<i32> = Vec::with_capacity(n);
        for i in 0..n {
            let next_idx = (i + 1) % n;
            if colors[i] != colors[next_idx] {
                is_alternating.push(1);
            } else {
                is_alternating.push(0);
            }
        }

        let mut extended_is_alternating: Vec<i32> = Vec::with_capacity(n + k_usize - 1);
        extended_is_alternating.extend_from_slice(&is_alternating);
        for i in 0..k_usize - 1 {
            extended_is_alternating.push(is_alternating[i]);
        }

        let mut ans = 0;
        let mut current_alternating_pairs = 0;

        for i in 0..k_usize - 1 {
            current_alternating_pairs += extended_is_alternating[i];
        }

        if current_alternating_pairs == (k - 1) as i32 {
            ans += 1;
        }

        for i in 1..n {
            current_alternating_pairs -= extended_is_alternating[i - 1];
            current_alternating_pairs += extended_is_alternating[i + k_usize - 2];

            if current_alternating_pairs == (k - 1) as i32 {
                ans += 1;
            }
        }

        ans
    }
}