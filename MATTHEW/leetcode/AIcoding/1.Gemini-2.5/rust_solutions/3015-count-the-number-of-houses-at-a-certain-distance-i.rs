impl Solution {
    pub fn count_of_pairs(n: i32, x: i32, y: i32) -> Vec<i32> {
        let mut ans = vec![0; n as usize];

        let (x_prime, y_prime) = if x < y { (x, y) } else { (y, x) };

        for i in 1..=n {
            for j in i + 1..=n {
                let d_direct = j - i;

                let d_path_i_to_x_to_y_to_j = (i - x_prime).abs() + 1 + (j - y_prime).abs();
                let d_path_i_to_y_to_x_to_j = (i - y_prime).abs() + 1 + (j - x_prime).abs();

                let d_special = d_path_i_to_x_to_y_to_j.min(d_path_i_to_y_to_x_to_j);

                let min_dist = d_direct.min(d_special);

                ans[(min_dist - 1) as usize] += 1;
            }
        }

        ans
    }
}