impl Solution {
    pub fn max_distance(colors: Vec<i32>) -> i32 {
        let n = colors.len();
        let mut max_dist = 0;
        for i in 0..n {
            for j in (i + 1)..n {
                if colors[i] != colors[j] {
                    max_dist = max_dist.max((j - i) as i32);
                }
            }
        }
        max_dist
    }
}