impl Solution {
    pub fn find_champion(n: i32, matches: Vec<Vec<i32>>) -> i32 {
        let n_usize = n as usize;
        let mut in_degree = vec![0; n_usize];
        let mut out_degree = vec![0; n_usize];

        for m in matches {
            let winner = m[0] as usize;
            let loser = m[1] as usize;
            in_degree[loser] += 1;
            out_degree[winner] += 1;
        }

        let mut champion_candidate = -1;
        let mut champion_count = 0;

        for i in 0..n_usize {
            // A champion team is defined as a team that defeats every other team.
            // This implies two conditions:
            // 1. The team must not have lost any match (in_degree == 0).
            // 2. The team must have defeated all n-1 other teams (out_degree == n-1).
            if in_degree[i] == 0 && out_degree[i] == (n - 1) {
                champion_candidate = i as i32;
                champion_count += 1;
            }
        }

        if champion_count == 1 {
            champion_candidate
        } else {
            -1
        }
    }
}