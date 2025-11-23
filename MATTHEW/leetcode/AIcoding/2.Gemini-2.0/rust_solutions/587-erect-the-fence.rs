impl Solution {
    pub fn outer_trees(trees: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        if trees.len() <= 3 {
            return trees;
        }

        let mut points = trees;
        points.sort();

        let mut upper: Vec<Vec<i32>> = Vec::new();
        let mut lower: Vec<Vec<i32>> = Vec::new();

        for p in &points {
            while upper.len() >= 2 && Self::cross_product(&upper[upper.len() - 2], &upper[upper.len() - 1], &p) < 0 {
                upper.pop();
            }
            upper.push(p.clone());
        }

        for p in points.iter().rev() {
            while lower.len() >= 2 && Self::cross_product(&lower[lower.len() - 2], &lower[lower.len() - 1], &p) < 0 {
                lower.pop();
            }
            lower.push(p.clone());
        }

        upper.pop();
        lower.pop();

        let mut hull = upper;
        hull.extend(lower);

        hull.sort();
        hull.dedup();

        hull
    }

    fn cross_product(a: &Vec<i32>, b: &Vec<i32>, c: &Vec<i32>) -> i32 {
        (b[0] - a[0]) * (c[1] - a[1]) - (b[1] - a[1]) * (c[0] - a[0])
    }
}