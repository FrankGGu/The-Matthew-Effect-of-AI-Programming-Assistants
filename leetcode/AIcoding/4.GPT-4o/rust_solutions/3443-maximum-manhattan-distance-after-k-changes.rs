impl Solution {
    pub fn max_distance(arr: Vec<i32>, k: i32) -> i32 {
        let n = arr.len();
        let mut max_distance = 0;

        for i in 0..n {
            for j in 0..n {
                if (arr[i] - arr[j]).abs() <= k {
                    max_distance = max_distance.max((i as i32 - j as i32).abs());
                }
            }
        }

        max_distance
    }
}