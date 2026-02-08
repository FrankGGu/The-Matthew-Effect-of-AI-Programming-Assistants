impl Solution {
    pub fn remove_duplicates(nums: &mut Vec<i32>) -> i32 {
        if nums.len() <= 2 {
            return nums.len() as i32;
        }

        let mut k = 2; // k is the pointer for the next position to write

        for i in 2..nums.len() {
            // If the current element is different from the element at k-2,
            // it means we haven't seen this element twice already (or it's a new distinct element).
            // So, we can place it at position k.
            if nums[i] != nums[k - 2] {
                nums[k] = nums[i];
                k += 1;
            }
        }

        k as i32
    }
}