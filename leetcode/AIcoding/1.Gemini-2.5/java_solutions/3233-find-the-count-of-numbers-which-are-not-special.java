import java.util.Arrays;

class Solution {
    public int nonSpecialCount(int l, int r) {
        int maxPrimeCheck = (int) Math.sqrt(r);

        boolean[] is_prime = new boolean[maxPrimeCheck + 1];
        Arrays.fill(is_prime, true);
        if (maxPrimeCheck >= 0) {
            is_prime[0] = false;
        }
        if (maxPrimeCheck >= 1) {
            is_prime[1] = false;
        }

        for (int p = 2; p * p <= maxPrimeCheck; p++) {
            if (is_prime[p]) {
                for (int i = p * p; i <= maxPrimeCheck; i += p) {
                    is_prime[i] = false;
                }
            }
        }

        int specialCount = 0;
        for (int p = 2; p <= maxPrimeCheck; p++) {
            if (is_prime[p]) {
                long square = (long) p * p; 
                if (square >= l && square <= r) {
                    specialCount++;
                }
            }
        }

        return (r - l + 1) - specialCount;
    }
}