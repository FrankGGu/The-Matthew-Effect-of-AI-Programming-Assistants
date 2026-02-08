class Solution {
    public int maxPrimeDifference(int[] nums) {
        int firstPrimeIndex = -1;
        int lastPrimeIndex = -1;

        for (int i = 0; i < nums.length; i++) {
            if (isPrime(nums[i])) {
                if (firstPrimeIndex == -1) {
                    firstPrimeIndex = i;
                }
                lastPrimeIndex = i;
            }
        }

        if (firstPrimeIndex == -1) {
            return 0; 
        }

        return lastPrimeIndex - firstPrimeIndex;
    }

    private boolean isPrime(int n) {
        if (n <= 1) {
            return false;
        }
        if (n == 2) {
            return true;
        }
        if (n % 2 == 0) {
            return false;
        }
        for (int i = 3; i * i <= n; i += 2) {
            if (n % i == 0) {
                return false;
            }
        }
        return true;
    }
}