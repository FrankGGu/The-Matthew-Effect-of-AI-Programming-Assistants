impl Solution {
    pub fn punishment_number(n: i32) -> i32 {
        (1..=n)
            .map(|x| x * x)
            .filter(|&x| Self::is_sum_of_squares(x))
            .sum()
    }

    fn is_sum_of_squares(x: i32) -> bool {
        let s = (x as f64).sqrt() as i32;
        let mut dp = vec![false; x as usize + 1];
        dp[0] = true;

        for i in 1..=s {
            let square = i * i;
            for j in (square..=x).rev() {
                dp[j as usize] = dp[j as usize] || dp[(j - square) as usize];
            }
        }
        dp[x as usize]
    }
}