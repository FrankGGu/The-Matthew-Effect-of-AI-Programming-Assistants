class Solution {
    public int diagonalPrime(int[][] nums) {
        int n = nums.length;
        int maxPrime = 0;

        for (int i = 0; i < n; i++) {
            // Main diagonal
            int val1 = nums[i][i];
            if (isPrime(val1)) {
                maxPrime = Math.max(maxPrime, val1);
            }

            // Anti-diagonal
            int val2 = nums[i][n - 1 - i];
            if (isPrime(val2)) {
                maxPrime = Math.max(maxPrime, val2);
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