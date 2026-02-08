public class Solution {

import java.util.*;

public class Solution {
    public int maximumNumberOfPrimes(int n) {
        boolean[] isPrime = new boolean[n + 1];
        Arrays.fill(isPrime, true);
        isPrime[0] = isPrime[1] = false;
        for (int i = 2; i * i <= n; i++) {
            if (isPrime[i]) {
                for (int j = i * i; j <= n; j += i) {
                    isPrime[j] = false;
                }
            }
        }

        Set<Integer> primes = new HashSet<>();
        for (int i = 2; i <= n; i++) {
            if (isPrime[i]) {
                primes.add(i);
            }
        }

        int count = 0;
        for (int prime : primes) {
            if (n % prime == 0) {
                count++;
                n /= prime;
            }
        }

        return count;
    }
}
}