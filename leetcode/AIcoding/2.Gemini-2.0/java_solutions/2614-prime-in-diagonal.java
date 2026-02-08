class Solution {
    public int diagonalPrime(int[][] nums) {
        int maxPrime = 0;
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            if (isPrime(nums[i][i])) {
                maxPrime = Math.max(maxPrime, nums[i][i]);
            }
            if (isPrime(nums[i][n - 1 - i])) {
                maxPrime = Math.max(maxPrime, nums[i][n - 1 - i]);
            }
        }

        return maxPrime;
    }

    private boolean isPrime(int num) {
        if (num <= 1) {
            return false;
        }
        for (int i = 2; i * i <= num; i++) {
            if (num % i == 0) {
                return false;
            }
        }
        return true;
    }
}