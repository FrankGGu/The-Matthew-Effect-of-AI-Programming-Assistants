impl Solution {
    pub fn max_height(cuboids: Vec<Vec<i32>>) -> i32 {
        let mut cuboids = cuboids;
        for cuboid in &mut cuboids {
            cuboid.sort();
        }
        cuboids.sort_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else if a[1] != b[1] {
                a[1].cmp(&b[1])
            } else {
                a[2].cmp(&b[2])
            }
        });

        let n = cuboids.len();
        let mut dp = vec![0; n];
        let mut max_height = 0;

        for i in 0..n {
            dp[i] = cuboids[i][2];
            for j in 0..i {
                if cuboids[i][0] >= cuboids[j][0] && cuboids[i][1] >= cuboids[j][1] && cuboids[i][2] >= cuboids[j][2] {
                    dp[i] = std::cmp::max(dp[i], dp[j] + cuboids[i][2]);
                }
            }
            max_height = std::cmp::max(max_height, dp[i]);
        }

        max_height
    }
}