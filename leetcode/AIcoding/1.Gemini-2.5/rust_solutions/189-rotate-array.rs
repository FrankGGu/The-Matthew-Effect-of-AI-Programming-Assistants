impl Solution {
    pub fn rotate(nums: &mut Vec<i32>, k: i32) {
        let n = nums.len();
        if n == 0 {
            return;
        }

        let k_effective = k as usize % n;

        if k_effective == 0 {
            return;
        }

        // Step 1: Reverse the entire array
        nums.reverse();

        // Step 2: Reverse the first k_effective elements
        nums[0..k_effective].reverse();

        // Step 3: Reverse the remaining n - k_effective elements
        nums[k_effective..n].reverse();
    }
}