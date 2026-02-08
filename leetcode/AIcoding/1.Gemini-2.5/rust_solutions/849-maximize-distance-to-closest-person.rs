impl Solution {
    pub fn max_dist_to_closest(seats: Vec<i32>) -> i32 {
        let n = seats.len();
        let mut person_indices = Vec::new();

        for (i, &seat) in seats.iter().enumerate() {
            if seat == 1 {
                person_indices.push(i as i32);
            }
        }

        let mut max_dist = 0;

        // Calculate distance for empty seats before the first person
        // This is simply the index of the first person
        max_dist = person_indices[0];

        // Calculate distance for empty seats between two people
        // For each gap, the maximum distance to the closest person is half the gap size
        for i in 0..(person_indices.len() - 1) {
            let p1 = person_indices[i];
            let p2 = person_indices[i+1];
            max_dist = max_dist.max((p2 - p1) / 2);
        }

        // Calculate distance for empty seats after the last person
        // This is (total length - 1) - index of the last person
        max_dist = max_dist.max((n as i32 - 1) - person_indices.last().unwrap());

        max_dist
    }
}