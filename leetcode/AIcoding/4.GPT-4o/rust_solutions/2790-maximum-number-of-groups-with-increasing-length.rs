impl Solution {
    pub fn maximum_groups(grades: Vec<i32>) -> i32 {
        let n = grades.len();
        let mut k = 0;
        while k * (k + 1) / 2 <= n {
            k += 1;
        }
        k - 1
    }
}