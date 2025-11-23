impl Solution {
    pub fn count_negatives(grid: Vec<Vec<i32>>) -> i32 {
        let mut count = 0;
        for row in grid {
            let mut left = 0;
            let mut right = row.len() as i32 - 1;
            while left <= right {
                let mid = left + (right - left) / 2;
                if row[mid as usize] < 0 {
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
            count += row.len() as i32 - left;
        }
        count
    }
}