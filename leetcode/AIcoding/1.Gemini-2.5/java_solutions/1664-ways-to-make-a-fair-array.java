class Solution {
    public int waysToMakeFair(int[] nums) {
        int n = nums.length;
        if (n == 0) {
            return 0;
        }
        // If n=1, removing the only element results in an empty array.
        // Sum of even-indexed elements = 0, sum of odd-indexed elements = 0.
        // 0 == 0, so it's always fair.
        if (n == 1) {
            return 1;
        }

        int totalEvenSum = 0;
        int totalOddSum = 0;

        // Calculate initial total sums for even and odd indexed elements
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                totalEvenSum += nums[i];
            } else {
                totalOddSum += nums[i];
            }
        }

        int count = 0;
        int currentEvenSumLeft = 0; // Sum of even-indexed elements before current i
        int currentOddSumLeft = 0;  // Sum of odd-indexed elements before current i

        // Iterate through each element, considering it for removal
        for (int i = 0; i < n; i++) {
            // Calculate sums of elements to the right of i in the original array.
            // These are the elements whose indices will shift and parity will flip.
            int evenSumRight;
            int oddSumRight;

            if (i % 2 == 0) { // nums[i] is at an even index
                // Remove nums[i] from totalEvenSum to get sum of even-indexed elements to its right
                evenSumRight = totalEvenSum - currentEvenSumLeft - nums[i];
                // Sum of odd-indexed elements to its right remains totalOddSum - currentOddSumLeft
                oddSumRight = totalOddSum - currentOddSumLeft;
            } else { // nums[i] is at an odd index
                // Sum of even-indexed elements to its right remains totalEvenSum - currentEvenSumLeft
                evenSumRight = totalEvenSum - currentEvenSumLeft;
                // Remove nums[i] from totalOddSum to get sum of odd-indexed elements to its right
                oddSumRight = totalOddSum - currentOddSumLeft - nums[i];
            }

            // Calculate new sums for the modified array
            // Elements to the left of i keep their index parity.
            // Elements to the right of i flip their index parity (even becomes odd, odd becomes even).
            int newEvenSum = currentEvenSumLeft + oddSumRight;
            int newOddSum = currentOddSumLeft + evenSumRight;

            if (newEvenSum == newOddSum) {
                count++;
            }

            // Update currentEvenSumLeft and currentOddSumLeft for the next iteration
            // nums[i] now becomes part of the "left" sum for the next i.
            if (i % 2 == 0) {
                currentEvenSumLeft += nums[i];
            } else {
                currentOddSumLeft += nums[i];
            }
        }

        return count;
    }
}