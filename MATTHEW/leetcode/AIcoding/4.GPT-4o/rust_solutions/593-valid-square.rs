pub struct Solution;

impl Solution {
    pub fn valid_square(p1: Vec<i32>, p2: Vec<i32>, p3: Vec<i32>, p4: Vec<i32>) -> bool {
        fn dist_sq(p1: &Vec<i32>, p2: &Vec<i32>) -> i64 {
            let dx = p1[0] - p2[0];
            let dy = p1[1] - p2[1];
            (dx * dx + dy * dy) as i64
        }

        let points = vec![p1, p2, p3, p4];
        let mut dists = vec![];

        for i in 0..4 {
            for j in (i + 1)..4 {
                dists.push(dist_sq(&points[i], &points[j]));
            }
        }

        dists.sort();
        dists.dedup();

        dists.len() == 2 && dists[0] > 0 && dists[0] == dists[1] * 2
    }
}