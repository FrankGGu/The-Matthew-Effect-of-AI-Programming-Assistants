impl Solution {
    pub fn find_in_mountain_array(target: i32, mountain_arr: &MountainArray) -> i32 {
        let n = mountain_arr.length();
        let mut l = 0;
        let mut r = n - 1;
        let mut peak = 0;

        while l < r {
            let mid = l + (r - l) / 2;
            if mountain_arr.get(mid) < mountain_arr.get(mid + 1) {
                l = mid + 1;
            } else {
                r = mid;
            }
        }
        peak = l;

        l = 0;
        r = peak;
        while l <= r {
            let mid = l + (r - l) / 2;
            let val = mountain_arr.get(mid);
            if val == target {
                return mid;
            } else if val < target {
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }

        l = peak + 1;
        r = n - 1;
        while l <= r {
            let mid = l + (r - l) / 2;
            let val = mountain_arr.get(mid);
            if val == target {
                return mid;
            } else if val < target {
                r = mid - 1;
            } else {
                l = mid + 1;
            }
        }

        -1
    }
}