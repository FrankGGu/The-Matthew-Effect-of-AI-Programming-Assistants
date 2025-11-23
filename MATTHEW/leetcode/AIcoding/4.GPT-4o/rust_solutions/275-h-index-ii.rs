impl Solution {
    pub fn h_index(citations: Vec<i32>) -> i32 {
        let mut left = 0;
        let mut right = citations.len() as i32;

        while left < right {
            let mid = left + (right - left) / 2;
            if citations[mid as usize] < (mid + 1) as i32 {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        citations.len() as i32 - left
    }
}