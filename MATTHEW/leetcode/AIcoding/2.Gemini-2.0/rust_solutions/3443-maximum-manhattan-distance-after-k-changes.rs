impl Solution {
    pub fn max_manhattan(points: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut max1 = i32::min_value();
        let mut min1 = i32::max_value();
        let mut max2 = i32::min_value();
        let mut min2 = i32::max_value();

        for point in &points {
            let x = point[0];
            let y = point[1];
            max1 = max1.max(x + y);
            min1 = min1.min(x + y);
            max2 = max2.max(x - y);
            min2 = min2.min(x - y);
        }

        let ans = (max1 - min1).max(max2 - min2);
        (ans + 2 * k).min(1000000000)
    }
}