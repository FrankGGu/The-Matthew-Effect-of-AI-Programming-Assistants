impl Solution {
    pub fn max_height(cuboids: Vec<Vec<i32>>) -> i32 {
        let mut cuboids = cuboids;
        for cuboid in cuboids.iter_mut() {
            cuboid.sort();
        }
        cuboids.sort();
        let n = cuboids.len();
        let mut dp = vec![0; n];
        let mut res = 0;
        for i in 0..n {
            dp[i] = cuboids[i][2];
            for j in 0..i {
                if cuboids[j][0] <= cuboids[i][0] && cuboids[j][1] <= cuboids[i][1] && cuboids[j][2] <= cuboids[i][2] {
                    dp[i] = dp[i].max(dp[j] + cuboids[i][2]);
                }
            }
            res = res.max(dp[i]);
        }
        res
    }
}