impl Solution {
    pub fn maximum_groups(grades: Vec<i32>) -> i32 {
        let n = grades.len() as i64;
        let mut left = 1;
        let mut right = n;
        let mut result = 0;

        while left <= right {
            let mid = left + (right - left) / 2;
            let total = mid * (mid + 1) / 2;
            if total <= n {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        result as i32
    }
}