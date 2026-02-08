impl Solution {
    pub fn find_closest_elements(arr: Vec<i32>, k: i32, x: i32) -> Vec<i32> {
        let mut left = 0;
        let mut right = arr.len() as i32 - 1;

        while right - left >= k {
            if (arr[left as usize] - x).abs() > (arr[right as usize] - x).abs() {
                left += 1;
            } else {
                right -= 1;
            }
        }

        arr[left as usize..=right as usize].to_vec()
    }
}