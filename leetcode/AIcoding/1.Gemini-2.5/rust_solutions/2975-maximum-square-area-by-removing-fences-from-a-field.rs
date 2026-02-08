use std::collections::HashSet;

impl Solution {
    pub fn maximize_square_area(n: i32, m: i32, h_fences: Vec<i32>, v_fences: Vec<i32>) -> i32 {
        let modulo = 1_000_000_007;

        let mut h_coords = h_fences;
        h_coords.push(1);
        h_coords.sort_unstable();

        let mut v_coords = v_fences;
        v_coords.push(1);
        v_coords.sort_unstable();

        let mut h_distances: HashSet<i32> = HashSet::new();
        for i in 0..h_coords.len() {
            for j in (i + 1)..h_coords.len() {
                h_distances.insert(h_coords[j] - h_coords[i]);
            }
        }

        let mut max_side_length = 0;
        for i in 0..v_coords.len() {
            for j in (i + 1)..v_coords.len() {
                let dist = v_coords[j] - v_coords[i];
                if h_distances.contains(&dist) {
                    max_side_length = max_side_length.max(dist);
                }
            }
        }

        if max_side_length == 0 {
            return 0;
        }

        let area = (max_side_length as i64 * max_side_length as i64) % modulo;

        area as i32
    }
}