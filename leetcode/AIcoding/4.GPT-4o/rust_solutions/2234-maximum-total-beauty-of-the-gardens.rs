impl Solution {
    pub fn maximum_beauty(a: Vec<i32>, k: i32) -> i32 {
        let mut a = a;
        a.sort();
        let n = a.len();
        let mut max_beauty = 0;
        let mut left = 0;

        for right in 0..n {
            while a[right] - a[left] > k {
                left += 1;
            }
            max_beauty = max_beauty.max((right - left + 1) as i32);
        }

        max_beauty
    }
}