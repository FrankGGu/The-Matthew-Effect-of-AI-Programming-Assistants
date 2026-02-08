class Solution {
    public int identifyOutlier(int[] nums) {
        int evenCount = 0;
        int oddCount = 0;
        int lastEven = -1;
        int lastOdd = -1;

        for (int i = 0; i < nums.length; i++) {
            if (nums[i] % 2 == 0) {
                evenCount++;
                lastEven = nums[i];
            } else {
                oddCount++;
                lastOdd = nums[i];
            }
        }

        if (evenCount == 1) {
            return lastEven;
        } else {
            return lastOdd;
        }
    }
}