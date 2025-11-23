impl Solution {
    pub fn num_of_ways(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut comb = vec![vec![0; n + 1]; n + 1];
        for i in 0..=n {
            comb[i][0] = 1;
            comb[i][i] = 1;
        }
        for i in 2..=n {
            for j in 1..i {
                comb[i][j] = (comb[i - 1][j - 1] + comb[i - 1][j]) % 1_000_000_007;
            }
        }

        fn solve(nums: &[i32], comb: &Vec<Vec<i32>>) -> i64 {
            if nums.len() <= 1 {
                return 1;
            }
            let root = nums[0];
            let left: Vec<i32> = nums[1..].iter().filter(|&&x| x < root).cloned().collect();
            let right: Vec<i32> = nums[1..].iter().filter(|&&x| x > root).cloned().collect();

            let left_ways = solve(&left, comb);
            let right_ways = solve(&right, comb);
            let n = nums.len() as usize;
            let l = left.len() as usize;
            let r = right.len() as usize;
            ((comb[l + r][l] as i64) * left_ways % 1_000_000_007 * right_ways % 1_000_000_007) % 1_000_000_007
        }

        (solve(&nums, &comb) - 1) as i32
    }
}