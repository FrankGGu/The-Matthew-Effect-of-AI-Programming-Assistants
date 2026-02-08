public class Solution {
    public int sumLargestPrimeSubstrings(String s) {
        int n = s.length();
        int maxSum = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j <= n; j++) {
                String substr = s.substring(i, j);
                if (isPrime(Integer.parseInt(substr))) {
                    maxSum = Math.max(maxSum, Integer.parseInt(substr));
                }
            }
        }
        return maxSum;
    }

    private boolean isPrime(int num) {
        if (num < 2) return false;
        for (int i = 2; i * i <= num; i++) {
            if (num % i == 0) return false;
        }
        return true;
    }
}