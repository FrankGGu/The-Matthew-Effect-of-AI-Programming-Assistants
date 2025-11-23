impl Solution {
    pub fn max_height(cuboids: Vec<Vec<i32>>) -> i32 {
        let n = cuboids.len();
        let mut cubes = cuboids;
        for c in &mut cubes {
            c.sort();
        }
        cubes.sort();
        let mut dp = vec![0; n];
        for i in 0..n {
            dp[i] = cubes[i][2];
            for j in 0..i {
                if cubes[j][0] <= cubes[i][0] && cubes[j][1] <= cubes[i][1] && cubes[j][2] <= cubes[i][2] {
                    dp[i] = dp[i].max(dp[j] + cubes[i][2]);
                }
            }
        }
        *dp.iter().max().unwrap()
    }
}