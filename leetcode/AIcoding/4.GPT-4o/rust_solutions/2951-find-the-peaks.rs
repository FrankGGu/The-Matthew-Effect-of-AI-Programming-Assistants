pub fn find_peak_element(nums: Vec<i32>) -> i32 {
    let n = nums.len();
    let mut left = 0;
    let mut right = n as i32 - 1;

    while left < right {
        let mid = left + (right - left) / 2;
        if nums[mid as usize] < nums[mid as usize + 1] {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    left
}