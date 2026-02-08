struct MountainArray;
impl MountainArray {
    fn get(&self, index: i32) -> i32;
    fn length(&self) -> i32;
}

impl Solution {
    pub fn find_in_mountain_array(target: i32, mountainArr: &MountainArray) -> i32 {
        let n = mountainArr.length();
        let mut left = 0;
        let mut right = n - 1;

        // Find peak
        while left < right {
            let mid = left + (right - left) / 2;
            if mountainArr.get(mid) < mountainArr.get(mid + 1) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        let peak = left;

        // Search in left part (ascending)
        left = 0;
        right = peak;
        while left <= right {
            let mid = left + (right - left) / 2;
            let val = mountainArr.get(mid);
            if val == target {
                return mid;
            } else if val < target {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        // Search in right part (descending)
        left = peak;
        right = n - 1;
        while left <= right {
            let mid = left + (right - left) / 2;
            let val = mountainArr.get(mid);
            if val == target {
                return mid;
            } else if val > target {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        -1
    }
}