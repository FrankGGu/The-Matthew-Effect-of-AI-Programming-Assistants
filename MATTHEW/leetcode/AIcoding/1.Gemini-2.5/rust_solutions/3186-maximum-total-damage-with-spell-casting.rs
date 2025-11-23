impl Solution {
    pub fn max_total_damage(damage: Vec<i32>) -> i64 {
        let mut max_val = 0;
        for &d in &damage {
            if d > max_val {
                max_val = d;
            }
        }

        // freq[i] will store the total damage if we pick all spells with damage 'i'
        // i.e., i * count_of_i
        let mut freq = vec![0i64; (max_val + 1) as usize];
        for &d in &damage {
            freq[d as usize] += d as i64;
        }

        // dp[i] will store the maximum total damage considering spells up to damage 'i'
        let mut dp = vec![0i64; (max_val + 1) as usize];

        // Base cases
        // dp[0] is 0
        if max_val >= 1 {
            dp[1] = freq[1];
        }

        // Fill dp table
        for i in 2..=(max_val as usize) {
            dp[i] = dp[i-1].max(dp[i-2] + freq[i]);
        }

        dp[max_val as usize]
    }
}