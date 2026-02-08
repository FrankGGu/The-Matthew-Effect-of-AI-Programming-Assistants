impl Solution {
    pub fn max_distance_to_closest_person(seats: Vec<i32>) -> i32 {
        let n = seats.len();
        let mut left_distances = vec![0; n];
        let mut right_distances = vec![0; n];

        let mut last_person_idx = -1;
        for i in 0..n {
            if seats[i] == 1 {
                last_person_idx = i as i32;
            }
            if last_person_idx == -1 {
                left_distances[i] = n as i32; 
            } else {
                left_distances[i] = i as i32 - last_person_idx;
            }
        }

        last_person_idx = n as i32; 
        for i in (0..n).rev() {
            if seats[i] == 1 {
                last_person_idx = i as i32;
            }
            if last_person_idx == n as i32 {
                right_distances[i] = n as i32; 
            } else {
                right_distances[i] = last_person_idx - i as i32;
            }
        }

        let mut max_dist = 0;
        for i in 0..n {
            if seats[i] == 0 {
                max_dist = max_dist.max(left_distances[i].min(right_distances[i]));
            }
        }

        max_dist
    }
}