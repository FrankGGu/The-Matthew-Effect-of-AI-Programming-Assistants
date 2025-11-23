impl Solution {
    fn is_strictly_increasing(arr: &[i32]) -> bool {
        if arr.len() <= 1 {
            return true;
        }
        for k in 1..arr.len() {
            if arr[k] <= arr[k - 1] {
                return false;
            }
        }
        true
    }

    pub fn can_be_increasing(nums: Vec<i32>) -> bool {
        let n = nums.len();

        // If the array has 0, 1, or 2 elements, it can always be made strictly increasing
        // by removing at most one element.
        // For length 0 or 1, it's already strictly increasing.
        // For length 2, removing one element leaves a length 1 array, which is strictly increasing.
        if n <= 2 {
            return true;
        }

        // Try removing each element one by one and check if the remaining array is strictly increasing.
        for i in 0..n {
            let mut temp_vec = Vec::with_capacity(n - 1);
            for j in 0..n {
                if i != j {
                    temp_vec.push(nums[j]);
                }
            }
            if Solution::is_strictly_increasing(&temp_vec) {
                return true;
            }
        }

        // If no single removal results in a strictly increasing array, return false.
        false
    }
}