impl Solution {
    pub fn max_dist_to_closest(seats: Vec<i32>) -> i32 {
        let n = seats.len();
        let mut left = vec![0; n];
        let mut right = vec![0; n];

        for i in 0..n {
            if seats[i] == 1 {
                left[i] = 0;
            } else {
                left[i] = if i == 0 { n } else { left[i - 1] + 1 };
            }
        }

        for i in (0..n).rev() {
            if seats[i] == 1 {
                right[i] = 0;
            } else {
                right[i] = if i == n - 1 { n } else { right[i + 1] + 1 };
            }
        }

        (0..n).map(|i| left[i].min(right[i])).max().unwrap()
    }
}