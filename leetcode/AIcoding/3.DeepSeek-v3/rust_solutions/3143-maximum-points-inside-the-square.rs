use std::collections::HashMap;

impl Solution {
    pub fn max_points_inside_square(points: Vec<Vec<i32>>, s: String) -> i32 {
        let mut tags = HashMap::new();
        for (i, point) in points.iter().enumerate() {
            let x = point[0].abs();
            let y = point[1].abs();
            let max_dist = x.max(y);
            let c = s.chars().nth(i).unwrap();
            tags.entry(c).or_insert_with(Vec::new).push(max_dist);
        }

        let mut left = 0;
        let mut right = 1_000_000_000;
        let mut answer = 0;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mut possible = true;
            let mut count = 0;

            for (_, dists) in tags.iter() {
                let mut cnt = 0;
                for &dist in dists {
                    if dist <= mid {
                        cnt += 1;
                    }
                }
                if cnt > 1 {
                    possible = false;
                    break;
                }
                if cnt == 1 {
                    count += 1;
                }
            }

            if possible {
                answer = count;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        answer
    }
}