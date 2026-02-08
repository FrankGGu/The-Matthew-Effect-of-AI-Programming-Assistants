class Solution {
    public int maxDifference(int[] nums) {
        int evenCount = 0;
        int oddCount = 0;

        for (int num : nums) {
            if (num % 2 == 0) {
                evenCount++;
            } else {
                oddCount++;
            }
        }

        return Math.abs(evenCount - oddCount);
    }
}