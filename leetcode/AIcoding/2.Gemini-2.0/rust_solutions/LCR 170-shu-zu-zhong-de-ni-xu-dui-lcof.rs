impl Solution {
    pub fn reverse_pairs(nums: Vec<i32>) -> i32 {
        fn merge_sort(nums: &mut [i32], temp: &mut [i32]) -> i32 {
            if nums.len() <= 1 {
                return 0;
            }
            let mid = nums.len() / 2;
            let mut count = merge_sort(&mut nums[..mid], temp) + merge_sort(&mut nums[mid..], temp);
            let mut i = 0;
            let mut j = mid;
            let mut k = 0;
            while i < mid && j < nums.len() {
                if nums[i] as i64 > 2 * nums[j] as i64 {
                    count += (mid - i) as i32;
                    j += 1;
                } else {
                    i += 1;
                }
            }
            i = 0;
            j = mid;
            k = 0;
            while i < mid && j < nums.len() {
                if nums[i] <= nums[j] {
                    temp[k] = nums[i];
                    i += 1;
                } else {
                    temp[k] = nums[j];
                    j += 1;
                }
                k += 1;
            }
            while i < mid {
                temp[k] = nums[i];
                i += 1;
                k += 1;
            }
            while j < nums.len() {
                temp[k] = nums[j];
                j += 1;
                k += 1;
            }
            nums.copy_from_slice(&temp[..nums.len()]);
            count
        }

        let mut nums = nums;
        let mut temp = vec![0; nums.len()];
        merge_sort(&mut nums, &mut temp)
    }
}