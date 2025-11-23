impl Solution {
    pub fn min_max_manhattan_distance(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        if n <= 1 {
            return 0;
        }

        let mut min_sum = i32::MAX;
        let mut max_sum = i32::MIN;
        let mut min_diff = i32::MAX;
        let mut max_diff = i32::MIN;

        for point in points {
            let sum = point[0] + point[1];
            let diff = point[0] - point[1];

            min_sum = min_sum.min(sum);
            max_sum = max_sum.max(sum);
            min_diff = min_diff.min(diff);
            max_diff = max_diff.max(diff);
        }

        let max_manhattan = (max_sum - min_sum).max(max_diff - min_diff);
        max_manhattan
    }
}