class Solution {
    public long minimumReplacements(int[] nums) {
        long operations = 0;
        int n = nums.length;

        // Start from the last element, which will be the maximum allowed value for the element before it.
        // We use long for currentMax to handle potential large values during calculations.
        long currentMax = nums[n - 1]; 

        // Iterate from the second-to-last element to the first
        for (int i = n - 2; i >= 0; i--) {
            // Get the current number to process, cast to long for calculations
            long num = nums[i]; 

            if (num <= currentMax) {
                // If the current number is already less than or equal to the maximum allowed value
                // (which is determined by the processed elements to its right),
                // no replacements are needed for this number.
                // This number now becomes the new maximum allowed value for the element to its left.
                currentMax = num;
            } else {
                // If the current number is greater than the maximum allowed value,
                // it must be split.

                // Calculate 'k', the minimum number of parts 'num' needs to be split into.
                // This is equivalent to ceil(num / currentMax).
                // Using integer division: (num + currentMax - 1) / currentMax
                long k = (num + currentMax - 1) / currentMax;

                // The number of replacements needed for this 'num' is (k - 1).
                operations += (k - 1);

                // After splitting 'num' into 'k' parts, the largest possible value for the 
                // leftmost part (which will be compared with nums[i-1]) is num / k (integer division).
                // This is because to minimize replacements, we want the parts to be as large as possible
                // while ensuring the rightmost part is <= currentMax. By splitting into k parts,
                // the parts will be roughly num/k. The smallest possible value for the leftmost part
                // is floor(num/k). This becomes the new currentMax for the element to its left.
                currentMax = num / k;
            }
        }

        return operations;
    }
}