public class Solution {

import java.util.*;

public class Solution {
    public int[] findValidSplit(int[] nums) {
        int n = nums.length;
        int[] primeCount = new int[100001];
        int[] lastOccurrence = new int[100001];

        for (int i = 0; i < n; i++) {
            int num = nums[i];
            Set<Integer> primes = getPrimes(num);
            for (int p : primes) {
                lastOccurrence[p] = i;
            }
        }

        int res = 0;
        for (int i = 0; i < n; i++) {
            int num = nums[i];
            Set<Integer> primes = getPrimes(num);
            for (int p : primes) {
                primeCount[p]++;
            }

            boolean allZero = true;
            for (int p : primes) {
                if (primeCount[p] > 0 && lastOccurrence[p] > i) {
                    allZero = false;
                    break;
                }
            }

            if (allZero) {
                return new int[]{res, i};
            }
        }

        return new int[]{-1, -1};
    }

    private Set<Integer> getPrimes(int num) {
        Set<Integer> primes = new HashSet<>();
        for (int i = 2; i * i <= num; i++) {
            while (num % i == 0) {
                primes.add(i);
                num /= i;
            }
        }
        if (num > 1) {
            primes.add(num);
        }
        return primes;
    }
}
}