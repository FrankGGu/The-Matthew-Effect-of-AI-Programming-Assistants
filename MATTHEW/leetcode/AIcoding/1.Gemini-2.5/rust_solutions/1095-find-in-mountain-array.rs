pub struct MountainArray;

pub trait MountainArray {
    fn get(&self, index: i32) -> i32;
    fn length(&self) -> i32;
}

impl Solution {
    pub fn find_in_mountain_array(target: i32, mountain_arr: &impl MountainArray) -> i32 {
        let n = mountain_arr.length();

        let mut low = 0;
        let mut high = n - 1;
        let mut peak_idx = -1;

        while low < high {
            let mid = low + (high - low) / 2;
            if mountain_arr.get(mid) < mountain_arr.get(mid + 1) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        peak_idx = low;

        let result_asc = Self::binary_search_asc(mountain_arr, target, 0, peak_idx);
        if result_asc != -1 {
            return result_asc;
        }

        let result_desc = Self::binary_search_desc(mountain_arr, target, peak_idx + 1, n - 1);
        if result_desc != -1 {
            return result_desc;
        }

        -1
    }

    fn binary_search_asc(mountain_arr: &impl MountainArray, target: i32, mut low: i32, mut high: i32) -> i32 {
        while low <= high {
            let mid = low + (high - low) / 2;
            let val = mountain_arr.get(mid);
            if val == target {
                return mid;
            } else if val < target {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        -1
    }

    fn binary_search_desc(mountain_arr: &impl MountainArray, target: i32, mut low: i32, mut high: i32) -> i32 {
        while low <= high {
            let mid = low + (high - low) / 2;
            let val = mountain_arr.get(mid);
            if val == target {
                return mid;
            } else if val < target {
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        -1
    }
}