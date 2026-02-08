class Solution {
    public int diagonalPrime(int[][] nums) {
        int max = 0;
        for (int i = 0; i < nums.length; i++) {
            if (isPrime(nums[i][i])) {
                max = Math.max(max, nums[i][i]);
            }
            if (isPrime(nums[i][nums.length - 1 - i])) {
                max = Math.max(max, nums[i][nums.length - 1 - i]);
            }
        }
        return max;
    }

    private boolean isPrime(int n) {
        if (n < 2) return false;
        for (int i = 2; i * i <= n; i++) {
            if (n % i == 0) return false;
        }
        return true;
    }
}