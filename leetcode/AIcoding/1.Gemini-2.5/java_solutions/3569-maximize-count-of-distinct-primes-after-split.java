import java.util.ArrayList;
import java.util.List;

class Solution {
    private static List<Integer> primes;
    private static final int MAX_N_LIMIT = 100000;
    private static boolean[] isPrime;

    // Static block for Sieve of Eratosthenes to precompute primes
    static {
        sieve();
    }

    private static void sieve() {
        isPrime = new boolean[MAX_N_LIMIT + 1];
        for (int i = 0; i <= MAX_N_LIMIT; i++) {
            isPrime[i] = true;
        }
        isPrime[0] = false;
        isPrime[1] = false;

        for (int p = 2; p * p <= MAX_N_LIMIT; p++) {
            if (isPrime[p]) {
                for (int i = p * p; i <= MAX_N_LIMIT; i += p)
                    isPrime[i] = false;
            }
        }

        primes = new ArrayList<>();
        for (int i = 2; i <= MAX_N_LIMIT; i++) {
            if (isPrime[i]) {
                primes.add(i);
            }
        }
    }

    public int maximizeDistinctPrimes(int n) {
        long currentSum = 0;
        int count = 0;

        for (int prime : primes) {
            if (currentSum + prime <= n) {
                currentSum += prime;
                count++;
            } else {
                break;
            }
        }
        return count;
    }
}