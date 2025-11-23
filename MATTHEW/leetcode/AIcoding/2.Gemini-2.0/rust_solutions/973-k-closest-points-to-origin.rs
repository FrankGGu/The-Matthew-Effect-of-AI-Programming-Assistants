use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Eq, PartialEq)]
struct Point {
    distance: i32,
    point: Vec<i32>,
}

impl Ord for Point {
    fn cmp(&self, other: &Self) -> Ordering {
        other.distance.cmp(&self.distance)
    }
}

impl PartialOrd for Point {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn k_closest(points: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let mut heap: BinaryHeap<Point> = BinaryHeap::new();

        for point in points {
            let distance = point[0] * point[0] + point[1] * point[1];
            heap.push(Point { distance, point });

            if heap.len() as i32 > k {
                heap.pop();
            }
        }

        let mut result: Vec<Vec<i32>> = Vec::new();
        while let Some(point) = heap.pop() {
            result.push(point.point);
        }

        result
    }
}