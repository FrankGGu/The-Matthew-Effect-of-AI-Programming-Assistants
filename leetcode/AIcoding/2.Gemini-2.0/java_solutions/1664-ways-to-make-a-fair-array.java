class Solution {
    public int waysToMakeFair(int[] nums) {
        int n = nums.length;
        int evenSum = 0, oddSum = 0;
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                evenSum += nums[i];
            } else {
                oddSum += nums[i];
            }
        }

        int evenPrefixSum = 0, oddPrefixSum = 0;
        int count = 0;
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                if (evenPrefixSum + (oddSum - oddPrefixSum) == oddPrefixSum + (evenSum - evenPrefixSum - nums[i])) {
                    count++;
                }
                evenPrefixSum += nums[i];
            } else {
                if (evenPrefixSum + (oddSum - oddPrefixSum - nums[i]) == oddPrefixSum + (evenSum - evenPrefixSum)) {
                    count++;
                }
                oddPrefixSum += nums[i];
            }
        }
        return count;
    }
}