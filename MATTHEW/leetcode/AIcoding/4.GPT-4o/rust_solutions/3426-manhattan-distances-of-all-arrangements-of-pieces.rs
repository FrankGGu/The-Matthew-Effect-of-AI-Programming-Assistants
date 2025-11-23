impl Solution {
    pub fn manhattan_distance_sum(a: Vec<i32>) -> i32 {
        let n = a.len();
        let mut total_distance = 0;
        for i in 0..n {
            for j in 0..n {
                total_distance += (a[i] - a[j]).abs() * (i as i32 - j as i32).abs();
            }
        }
        total_distance
    }
}