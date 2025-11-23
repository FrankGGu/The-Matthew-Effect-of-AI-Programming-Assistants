use std::cmp::Ordering;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct Point {
    x: i32,
    y: i32,
}

impl Point {
    fn new(x: i32, y: i32) -> Self {
        Point { x, y }
    }
}

impl PartialOrd for Point {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for Point {
    fn cmp(&self, other: &Self) -> Ordering {
        match self.x.cmp(&other.x) {
            Ordering::Equal => self.y.cmp(&other.y),
            ord => ord,
        }
    }
}

fn cross(o: &Point, a: &Point, b: &Point) -> i32 {
    (a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x)
}

impl Solution {
    pub fn outer_trees(mut trees: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        if trees.len() <= 3 {
            return trees;
        }
        let mut points: Vec<Point> = trees.iter().map(|p| Point::new(p[0], p[1])).collect();
        points.sort();

        let mut hull: Vec<Point> = Vec::new();

        for p in points.iter() {
            while hull.len() >= 2 && cross(&hull[hull.len() - 2], &hull[hull.len() - 1], p) < 0 {
                hull.pop();
            }
            hull.push(*p);
        }

        hull.pop();

        for p in points.iter().rev() {
            while hull.len() >= 2 && cross(&hull[hull.len() - 2], &hull[hull.len() - 1], p) < 0 {
                hull.pop();
            }
            hull.push(*p);
        }

        hull.pop();

        let mut res: Vec<Vec<i32>> = hull.into_iter().map(|p| vec![p.x, p.y]).collect();
        res.sort();
        res.dedup();
        res
    }
}