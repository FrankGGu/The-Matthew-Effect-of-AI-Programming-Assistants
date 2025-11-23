class Solution {
    public long sumDigitDifferences(int[] nums) {
        long totalDiffSum = 0;
        int n = nums.length;

        // Create a temporary array to store the current state of numbers
        // as we extract digits from right to left (units, tens, hundreds, etc.).
        // This avoids modifying the original nums array and allows for efficient digit extraction
        // by repeatedly dividing by 10.
        int[] currentNums = new int[n];
        for (int i = 0; i < n; i++) {
            currentNums[i] = nums[i];
        }

        // Iterate through digit positions.
        // A number up to 10^9 has at most 10 digits (from units place, index 0, to billions place, index 9).
        // For example, 1,000,000,000 has a '1' at the 9th digit position (10^9 place).
        // We iterate a maximum of 10 times to cover all possible digit positions.
        for (int k = 0; k < 10; k++) { 
            // counts[d] will store how many numbers have digit 'd' at the current position 'k'.
            int[] counts = new int[10]; 

            // Flag to check if all numbers have become 0. If so, we can stop early.
            boolean allZeros = true; 

            // Extract the digit at position 'k' for all numbers and update counts.
            // Also, prepare numbers for the next digit position by dividing by 10.
            for (int i = 0; i < n; i++) {
                int digit = currentNums[i] % 10;
                counts[digit]++;
                currentNums[i] /= 10; 

                // If any number is still greater than 0, it means it has more digits to process.
                if (currentNums[i] > 0) {
                    allZeros = false;
                }
            }

            // Calculate the contribution of this digit position to the total sum.
            // For each pair of distinct digits (d1, d2) at this position,
            // the contribution is (count of d1) * (count of d2) * |d1 - d2|.
            for (int d1 = 0; d1 < 10; d1++) {
                // Optimization: if no numbers have digit d1, skip.
                if (counts[d1] == 0) continue; 

                for (int d2 = d1 + 1; d2 < 10; d2++) {
                    // Optimization: if no numbers have digit d2, skip.
                    if (counts[d2] == 0) continue; 

                    // Add the contribution to the total sum.
                    // Use long to prevent overflow as counts can be up to N (10^5)
                    // and the product can exceed Integer.MAX_VALUE.
                    totalDiffSum += (long)counts[d1] * counts[d2] * (d2 - d1);
                }
            }

            // If all numbers have been reduced to 0, it means there are no more digits to process.
            // We can break early.
            if (allZeros) {
                break;
            }
        }

        return totalDiffSum;
    }
}