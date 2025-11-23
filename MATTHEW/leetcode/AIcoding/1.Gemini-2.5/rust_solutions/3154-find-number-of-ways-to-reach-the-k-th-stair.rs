use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn ways_to_reach_kth_stair(k: i32) -> i32 {
        let mut memo: HashMap<(i32, u32), i32> = HashMap::new();
        let mod_val = 1_000_000_007;

        // The maximum number of jumps_made to consider.
        // For k=30, jumps_made can go up to 31 (e.g., 0 -> 1 -> 0 -> 2 -> ... -> 0 -> 2^31 -> ... -> k).
        // k+2 is a safe upper bound for jumps_made, as it covers k=0 (max jumps_made 1) and k=1 (max jumps_made 2).
        // For k=30, max_jumps_considered will be 32.
        let max_jumps_considered = (k + 2) as u32; 

        // The maximum current_stair to consider.
        // If current_stair is too far above k, it's unlikely to reach k efficiently.
        // A common heuristic is k + max_jumps_considered.
        // For k=30, max_jumps_considered=32, so max_stair_considered = 30 + 32 = 62.
        // This keeps the state space manageable for memoization.
        let max_stair_considered = k + (k + 2); // k + max_jumps_considered as i32

        Self::dfs(0, 0, k, max_jumps_considered, max_stair_considered, &mut memo, mod_val)
    }

    fn dfs(
        current_stair: i32,
        jumps_made: u32,
        k: i32,
        max_jumps_considered: u32,
        max_stair_considered: i32,
        memo: &mut HashMap<(i32, u32), i32>,
        mod_val: i32,
    ) -> i32 {
        // Pruning conditions:
        // 1. Cannot go below stair 0.
        if current_stair < 0 {
            return 0;
        }
        // 2. If too many jumps have been made, the jump distance (1 << jumps_made) becomes too large
        //    or we've explored enough jump sequences.
        if jumps_made >= max_jumps_considered {
            return 0;
        }
        // 3. If current_stair is too high, it's unlikely to reach k.
        //    Any further jump will take it even higher. Only option is to go down.
        //    This limits the search space for current_stair.
        if current_stair > max_stair_considered {
            return 0;
        }

        // Check memoization table
        if let Some(&res) = memo.get(&(current_stair, jumps_made)) {
            return res;
        }

        let mut ways = 0;

        // If current_stair is k, this specific state (current_stair, jumps_made) represents one way to reach k.
        // We count it and continue exploring, as other paths might also reach k from this state.
        if current_stair == k {
            ways = (ways + 1) % mod_val;
        }

        // Option 1: Jump
        // Calculate the next jump distance (1 << jumps_made).
        // Since jumps_made is u32 and max_jumps_considered is 32, jumps_made can go up to 31.
        // `1i32 << 31` is a valid operation for i32.
        let next_stair_jump = current_stair + (1i32 << jumps_made);
        let next_jumps_made = jumps_made + 1;
        ways = (ways + Self::dfs(
            next_stair_jump,
            next_jumps_made,
            k,
            max_jumps_considered,
            max_stair_considered,
            memo,
            mod_val,
        )) % mod_val;

        // Option 2: Go down
        // Can only go down if current_stair is greater than 0.
        if current_stair > 0 {
            let next_stair_down = current_stair - 1;
            let next_jumps_made_down = jumps_made; // jumps_made does not change when going down
            ways = (ways + Self::dfs(
                next_stair_down,
                next_jumps_made_down,
                k,
                max_jumps_considered,
                max_stair_considered,
                memo,
                mod_val,
            )) % mod_val;
        }

        // Store result in memoization table before returning
        memo.insert((current_stair, jumps_made), ways);
        ways
    }
}