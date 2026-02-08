class Solution {
    public int maxDivScore(int[] nums, int threshold) {
        int maxDivisor = 0;
        int maxCount = 0;

        for (int i = 1; i <= threshold; i++) {
            int count = 0;
            for (int num : nums) {
                if (num % i == 0) {
                    count++;
                }
            }
            if (count > maxCount || (count == maxCount && i > maxDivisor)) {
                maxCount = count;
                maxDivisor = i;
            }
        }
        return maxDivisor;
    }
}