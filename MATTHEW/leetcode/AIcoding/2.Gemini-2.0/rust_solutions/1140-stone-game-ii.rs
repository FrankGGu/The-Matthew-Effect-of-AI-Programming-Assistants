impl Solution {
    pub fn stone_game_ii(piles: Vec<i32>) -> i32 {
        let n = piles.len();
        let mut memo = vec![vec![0; n + 1]; n];
        let mut sums = vec![0; n + 1];
        for i in (0..n).rev() {
            sums[i] = sums[i + 1] + piles[i];
        }

        fn solve(i: usize, m: usize, piles: &Vec<i32>, sums: &Vec<i32>, memo: &mut Vec<Vec<i32>>) -> i32 {
            if i >= piles.len() {
                return 0;
            }
            if i + 2 * m >= piles.len() {
                return sums[i];
            }
            if memo[i][m] != 0 {
                return memo[i][m];
            }

            let mut ans = i32::MIN;
            for x in 1..=2 * m {
                ans = ans.max(sums[i] - solve(i + x, std::cmp::max(m, x), piles, sums, memo));
            }

            memo[i][m] = ans;
            ans
        }

        solve(0, 1, &piles, &sums, &mut memo)
    }
}