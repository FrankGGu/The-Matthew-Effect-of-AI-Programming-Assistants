impl Solution {
    pub fn max_distance(colors: Vec<i32>) -> i32 {
        let n = colors.len();
        let mut max_dist = 0;

        for j in (0..n).rev() {
            if colors[j] != colors[0] {
                max_dist = max_dist.max(j as i32);
                break;
            }
        }

        for i in 0..n {
            if colors[i] != colors[n - 1] {
                max_dist = max_dist.max((n - 1 - i) as i32);
                break;
            }
        }

        max_dist
    }
}