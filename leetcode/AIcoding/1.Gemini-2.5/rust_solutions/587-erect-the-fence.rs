use std::collections::HashSet;

struct Solution;

impl Solution {
    // Computes the cross product of vectors p1p2 and p1p3.
    // A positive value means p3 is to the left of vector p1p2 (counter-clockwise turn).
    // A negative value means p3 is to the right of vector p1p2 (clockwise turn).
    // A zero value means p1, p2, and p3 are collinear.
    fn cross_product(p1: &[i32], p2: &[i32], p3: &[i32]) -> i32 {
        (p2[0] - p1[0]) * (p3[1] - p1[1]) - (p2[1] - p1[1]) * (p3[0] - p1[0])
    }

    pub fn outer_trees(mut trees: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = trees.len();
        if n <= 2 {
            // If there are 0, 1, or 2 trees, all of them form the fence.
            return trees;
        }

        // Sort the trees lexicographically (by x-coordinate, then by y-coordinate).
        // This is crucial for the Monotone Chain algorithm.
        trees.sort_unstable_by_key(|p| (p[0], p[1]));

        let mut lower_hull: Vec<Vec<i32>> = Vec::new();
        // Build the lower hull.
        // Iterate through the sorted points from left to right.
        for i in 0..n {
            // While the last two points in the lower_hull and the current point form a "right turn"
            // (meaning the last point is not part of the convex hull), pop the last point.
            // A cross product < 0 indicates a right turn.
            while lower_hull.len() >= 2 && Self::cross_product(&lower_hull[lower_hull.len() - 2], &lower_hull[lower_hull.len() - 1], &trees[i]) < 0 {
                lower_hull.pop();
            }
            lower_hull.push(trees[i].clone());
        }

        let mut upper_hull: Vec<Vec<i32>> = Vec::new();
        // Build the upper hull.
        // Iterate through the sorted points from right to left (reverse order).
        for i in (0..n).rev() {
            // Similar logic: pop if a right turn is formed.
            while upper_hull.len() >= 2 && Self::cross_product(&upper_hull[upper_hull.len() - 2], &upper_hull[upper_hull.len() - 1], &trees[i]) < 0 {
                upper_hull.pop();
            }
            upper_hull.push(trees[i].clone());
        }

        // Combine the lower and upper hulls and remove duplicate points.
        // The leftmost and rightmost points will be present in both hulls.
        let mut result_set: HashSet<Vec<i32>> = HashSet::new();
        for p in lower_hull {
            result_set.insert(p);
        }
        for p in upper_hull {
            result_set.insert(p);
        }

        // Convert the HashSet back to a Vec<Vec<i32>> for the final result.
        result_set.into_iter().collect()
    }
}