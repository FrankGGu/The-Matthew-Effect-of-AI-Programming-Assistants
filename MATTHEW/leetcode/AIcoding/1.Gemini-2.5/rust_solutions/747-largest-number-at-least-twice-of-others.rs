impl Solution {
    pub fn dominant_index(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return -1;
        }

        let mut max1 = -1; // Largest element found so far
        let mut idx1 = -1; // Index of the largest element
        let mut max2 = -1; // Second largest element found so far

        for (i, &num) in nums.iter().enumerate() {
            if num > max1 {
                max2 = max1; // The previous largest becomes the new second largest
                max1 = num;
                idx1 = i as i32;
            } else if num > max2 {
                max2 = num; // Current number is not the largest, but is greater than the second largest
            }
        }

        if max1 >= 2 * max2 {
            idx1
        } else {
            -1
        }
    }
}