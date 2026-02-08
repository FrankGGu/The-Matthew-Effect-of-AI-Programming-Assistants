impl Solution {
    pub fn two_out_of_three(nums1: Vec<i32>, nums2: Vec<i32>, nums3: Vec<i32>) -> Vec<i32> {
        let mut counts = [0u8; 101]; // Array to store bitmasks for numbers 1 to 100

        // Process nums1: set bit 0 for numbers present in nums1
        for &num in nums1.iter() {
            counts[num as usize] |= 1;
        }

        // Process nums2: set bit 1 for numbers present in nums2
        for &num in nums2.iter() {
            counts[num as usize] |= 2;
        }

        // Process nums3: set bit 2 for numbers present in nums3
        for &num in nums3.iter() {
            counts[num as usize] |= 4;
        }

        let mut result = Vec::new();
        // Iterate through all possible numbers (1 to 100)
        for i in 1..=100 {
            let mask = counts[i];
            // Check if the number is present in at least two arrays.
            // This means at least two bits are set in its mask.
            // Possible masks for "two out of three":
            // 0b011 (3): in nums1 and nums2
            // 0b101 (5): in nums1 and nums3
            // 0b110 (6): in nums2 and nums3
            // 0b111 (7): in all three arrays
            if mask == 3 || mask == 5 || mask == 6 || mask == 7 {
                result.push(i as i32);
            }
        }

        result
    }
}