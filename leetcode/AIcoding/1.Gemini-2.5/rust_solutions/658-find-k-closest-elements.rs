impl Solution {
    pub fn find_closest_elements(arr: Vec<i32>, k: i32, x: i32) -> Vec<i32> {
        let mut left = 0;
        let mut right = arr.len() - 1;
        let k_usize = k as usize;

        while right - left + 1 > k_usize {
            let diff_left = (arr[left] - x).abs();
            let diff_right = (arr[right] - x).abs();

            if diff_left <= diff_right {
                right -= 1;
            } else {
                left += 1;
            }
        }

        arr[left..=right].to_vec()
    }
}