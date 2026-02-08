impl Solution {
    pub fn max_jumps(arr: Vec<i32>, d: i32) -> i32 {
        let n = arr.len();
        let mut memo = vec![0; n];

        let mut dfs = |idx: usize,
                       arr_ref: &Vec<i32>,
                       d_val: i32,
                       memo_ref: &mut Vec<i32>|
                       -> i32 {
            if memo_ref[idx] != 0 {
                return memo_ref[idx];
            }

            let mut current_max_jumps = 1;

            // Jump right
            for k in 1..=d_val {
                let next_idx = idx + k as usize;
                if next_idx >= arr_ref.len() {
                    break;
                }
                if arr_ref[idx] <= arr_ref[next_idx] {
                    break;
                }
                current_max_jumps = current_max_jumps.max(1 + dfs(next_idx, arr_ref, d_val, memo_ref));
            }

            // Jump left
            for k in 1..=d_val {
                if idx < k as usize {
                    break;
                }
                let next_idx = idx - k as usize;
                if arr_ref[idx] <= arr_ref[next_idx] {
                    break;
                }
                current_max_jumps = current_max_jumps.max(1 + dfs(next_idx, arr_ref, d_val, memo_ref));
            }

            memo_ref[idx] = current_max_jumps;
            current_max_jumps
        };

        let mut max_overall_jumps = 0;
        for i in 0..n {
            max_overall_jumps = max_overall_jumps.max(dfs(i, &arr, d, &mut memo));
        }

        max_overall_jumps
    }
}