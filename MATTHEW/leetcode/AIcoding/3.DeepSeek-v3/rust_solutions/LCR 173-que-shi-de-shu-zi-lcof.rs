impl Solution {
    pub fn take_attendance(records: Vec<i32>) -> i32 {
        let (mut left, mut right) = (0, records.len() as i32 - 1);
        while left <= right {
            let mid = left + (right - left) / 2;
            if records[mid as usize] == mid {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        left
    }
}