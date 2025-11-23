impl Solution {
    pub fn max_distance(colors: Vec<i32>) -> i32 {
        let n = colors.len();
        let mut max_dist = 0;

        // Calculate the maximum distance by fixing one house at index 0
        // and finding the furthest house with a different color.
        for j in (0..n).rev() {
            if colors[j] != colors[0] {
                max_dist = max_dist.max(j as i32);
                break; 
            }
        }

        // Calculate the maximum distance by fixing one house at index n-1
        // and finding the furthest house with a different color.
        for i in 0..n {
            if colors[i] != colors[n - 1] {
                max_dist = max_dist.max((n - 1 - i) as i32);
                break;
            }
        }

        max_dist
    }
}