class Solution {
    public boolean canThreePartsEqualSum(int[] arr) {
        int totalSum = 0;
        for (int num : arr) {
            totalSum += num;
        }

        if (totalSum % 3 != 0) {
            return false;
        }

        int targetSum = totalSum / 3;
        int currentSum = 0;
        int partsFound = 0;

        for (int i = 0; i < arr.length; i++) {
            currentSum += arr[i];
            if (currentSum == targetSum) {
                partsFound++;
                currentSum = 0; 
            }

            // If we have found two parts that sum to targetSum,
            // and there are still elements remaining in the array (i.e., i is not the last index),
            // then the remaining elements must form the third part.
            // Since the total sum is divisible by 3 and the first two parts sum to 2*targetSum,
            // the sum of the remaining elements will automatically be targetSum.
            // We only need to ensure that this third part is non-empty.
            if (partsFound == 2 && i < arr.length - 1) {
                return true;
            }
        }

        return false;
    }
}