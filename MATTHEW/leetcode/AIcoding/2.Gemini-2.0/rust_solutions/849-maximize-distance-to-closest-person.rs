impl Solution {
    pub fn max_dist_to_closest(seats: Vec<i32>) -> i32 {
        let n = seats.len();
        let mut max_dist = 0;
        let mut last_occupied = -1;

        for i in 0..n {
            if seats[i] == 1 {
                if last_occupied == -1 {
                    max_dist = i as i32;
                } else {
                    max_dist = max_dist.max((i - last_occupied) as i32 / 2);
                }
                last_occupied = i as i32;
            }
        }

        if last_occupied != (n - 1) as i32 {
            max_dist = max_dist.max((n - 1 - last_occupied) as i32);
        }

        max_dist
    }
}