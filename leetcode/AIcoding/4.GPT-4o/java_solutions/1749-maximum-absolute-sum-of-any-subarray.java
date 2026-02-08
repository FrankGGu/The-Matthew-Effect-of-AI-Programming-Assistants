class Solution {
    public int maxAbsoluteSum(int[] nums) {
        int maxEndingHere = 0, minEndingHere = 0;
        int maxSoFar = 0;

        for (int num : nums) {
            maxEndingHere = Math.max(maxEndingHere + num, num);
            minEndingHere = Math.min(minEndingHere + num, num);
            maxSoFar = Math.max(maxSoFar, Math.max(maxEndingHere, -minEndingHere));
        }

        return maxSoFar;
    }
}