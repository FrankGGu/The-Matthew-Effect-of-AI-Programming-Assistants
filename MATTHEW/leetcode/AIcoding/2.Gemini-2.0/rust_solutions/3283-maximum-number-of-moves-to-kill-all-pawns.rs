impl Solution {
    pub fn max_moves_to_kill_all_pawns(pawns: Vec<i32>) -> i32 {
        let n = pawns.len();
        let mut pawns = pawns;
        pawns.sort();

        let mut ans = 0;
        let mut used = vec![false; n];

        for i in 0..n {
            let mut found = false;
            for j in 0..n {
                if !used[j] && (pawns[i] == pawns[j] + 1 || pawns[i] == pawns[j] + 2) {
                    used[j] = true;
                    ans += 1;
                    found = true;
                    break;
                }
            }
            if !found {
                return -1;
            }
        }

        ans
    }
}