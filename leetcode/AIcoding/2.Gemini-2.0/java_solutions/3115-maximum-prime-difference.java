import java.util.Arrays;

class Solution {
    public int maximumPrimeDifference(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int maxDiff = -1;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (isPrime(nums[i]) && isPrime(nums[j])) {
                    maxDiff = Math.max(maxDiff, nums[j] - nums[i]);
                }
            }
        }
        return maxDiff;
    }

    private boolean isPrime(int n) {
        if (n <= 1) return false;
        for (int i = 2; i * i <= n; i++) {
            if (n % i == 0) return false;
        }
        return true;
    }
}