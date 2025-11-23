impl Solution {
    pub fn max_dist_to_closest(seats: Vec<i32>) -> i32 {
        let n = seats.len();
        let mut left = vec![n; n];
        let mut right = vec![n; n];

        let mut last = -1;
        for i in 0..n {
            if seats[i] == 1 {
                last = i as i32;
            } else if last != -1 {
                left[i] = (i as i32 - last) as usize;
            }
        }

        last = -1;
        for i in (0..n).rev() {
            if seats[i] == 1 {
                last = i as i32;
            } else if last != -1 {
                right[i] = (last - i as i32) as usize;
            }
        }

        let mut max_dist = 0;
        for i in 0..n {
            if seats[i] == 0 {
                let min_dist = std::cmp::min(left[i], right[i]);
                if min_dist != n {
                    max_dist = std::cmp::max(max_dist, min_dist);
                } else {
                    max_dist = std::cmp::max(max_dist, n);
                }
            }
        }

        max_dist as i32
    }
}