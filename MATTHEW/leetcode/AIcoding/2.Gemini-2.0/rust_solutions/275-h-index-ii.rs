impl Solution {
    pub fn h_index(citations: Vec<i32>) -> i32 {
        let n = citations.len();
        let mut left = 0;
        let mut right = n;

        while left < right {
            let mid = left + (right - left) / 2;
            if citations[mid] >= (n - mid) as i32 {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        (n - left) as i32
    }
}