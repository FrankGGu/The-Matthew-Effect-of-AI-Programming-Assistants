impl Solution {
    pub fn minimum_right_shifts(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut pivot = 0;
        let mut found_pivot = false;

        for i in 1..n {
            if nums[i] < nums[i - 1] {
                if found_pivot {
                    return -1;
                }
                pivot = i;
                found_pivot = true;
            }
        }

        if !found_pivot {
            return 0;
        }

        if nums[n - 1] <= nums[0] {
            (n - pivot) as i32
        } else {
            -1
        }
    }
}