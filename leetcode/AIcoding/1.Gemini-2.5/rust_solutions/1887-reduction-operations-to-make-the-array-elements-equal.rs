impl Solution {
    pub fn reduction_operations(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable();

        let n = nums.len();
        let mut operations = 0;

        // Iterate from the second-to-last element down to the first.
        // The loop variable 'i' will represent the index of the current element
        // we are considering as a target for reduction.
        // The 'i+1' element is the one that might be reduced.
        for i in (0..n - 1).rev() {
            // If the current element (nums[i]) is strictly smaller than the next element (nums[i+1]),
            // it means nums[i+1] represents a distinct value that needs to be reduced.
            // All elements from index i+1 to n-1 (inclusive) are conceptually
            // at the level of nums[i+1] (or higher, having been reduced to nums[i+1] in prior steps).
            // To reduce all these elements to the level of nums[i], we need one operation
            // for each of them.
            // The number of such elements is (n - 1) - (i + 1) + 1, which simplifies to n - 1 - i.
            if nums[i] < nums[i + 1] {
                operations += (n - 1) - i;
            }
        }

        operations
    }
}