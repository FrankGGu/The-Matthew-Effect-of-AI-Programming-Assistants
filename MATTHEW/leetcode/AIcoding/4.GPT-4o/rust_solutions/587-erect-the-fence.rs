use std::collections::HashSet;

pub fn outer_trees(points: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let mut points = points.clone();
    points.sort_unstable();

    let mut hull = vec![];

    for &point in &points {
        while hull.len() >= 2 {
            let p1 = &hull[hull.len() - 2];
            let p2 = &hull[hull.len() - 1];
            if (p2[0] - p1[0]) * (point[1] - p1[1]) - (p2[1] - p1[1]) * (point[0] - p1[0]) < 0 {
                hull.pop();
            } else {
                break;
            }
        }
        hull.push(point);
    }

    let lower_hull_size = hull.len();
    for i in (0..points.len()).rev() {
        let point = &points[i];
        while hull.len() > lower_hull_size {
            let p1 = &hull[hull.len() - 2];
            let p2 = &hull[hull.len() - 1];
            if (p2[0] - p1[0]) * (point[1] - p1[1]) - (p2[1] - p1[1]) * (point[0] - p1[0]) < 0 {
                hull.pop();
            } else {
                break;
            }
        }
        hull.push(point);
    }

    hull.into_iter().collect::<HashSet<_>>().into_iter().collect()
}