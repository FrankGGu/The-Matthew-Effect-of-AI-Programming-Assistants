use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Eq, PartialEq)]
struct PointWithDist {
    dist_sq: i64,
    point: Vec<i32>,
}

impl Ord for PointWithDist {
    fn cmp(&self, other: &Self) -> Ordering {
        self.dist_sq.cmp(&other.dist_sq)
    }
}

impl PartialOrd for PointWithDist {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

struct Solution;

impl Solution {
    pub fn k_closest(points: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let mut heap = BinaryHeap::new();

        for p in points {
            let x = p[0] as i64;
            let y = p[1] as i64;
            let dist_sq = x * x + y * y;

            let current_p_with_dist = PointWithDist { dist_sq, point: p };

            if heap.len() < k as usize {
                heap.push(current_p_with_dist);
            } else {
                if let Some(max_p_with_dist) = heap.peek() {
                    if current_p_with_dist.dist_sq < max_p_with_dist.dist_sq {
                        heap.pop();
                        heap.push(current_p_with_dist);
                    }
                }
            }
        }

        heap.into_iter().map(|p_with_dist| p_with_dist.point).collect()
    }
}