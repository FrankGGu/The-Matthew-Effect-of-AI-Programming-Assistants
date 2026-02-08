impl Solution {
    pub fn count_of_pairs(n: i32, x: i32, y: i32) -> Vec<i32> {
        let mut ans = vec![0; n as usize];

        let (x_norm, y_norm) = if x < y { (x, y) } else { (y, x) };

        for i in 1..=n {
            for j in i + 1..=n {
                let d1 = j - i;

                let d2 = (i - x_norm).abs() + 1 + (j - y_norm).abs();
                let d3 = (i - y_norm).abs() + 1 + (j - x_norm).abs();

                let current_min_dist = d1.min(d2).min(d3);

                ans[current_min_dist as usize] += 1;
            }
        }

        ans.remove(0);
        ans
    }
}