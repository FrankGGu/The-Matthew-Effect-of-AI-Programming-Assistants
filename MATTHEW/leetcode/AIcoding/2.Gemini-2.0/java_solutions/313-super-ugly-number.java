class Solution {
    public int nthSuperUglyNumber(int n, int[] primes) {
        int[] ugly = new int[n];
        int[] idx = new int[primes.length];
        ugly[0] = 1;

        for (int i = 1; i < n; i++) {
            int min = Integer.MAX_VALUE;
            for (int j = 0; j < primes.length; j++) {
                min = Math.min(min, primes[j] * ugly[idx[j]]);
            }
            ugly[i] = min;

            for (int j = 0; j < primes.length; j++) {
                if (primes[j] * ugly[idx[j]] == min) {
                    idx[j]++;
                }
            }
        }

        return ugly[n - 1];
    }
}