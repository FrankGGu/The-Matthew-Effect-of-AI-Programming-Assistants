public class Solution {

import java.util.*;

public class Solution {
    public int largestKDivisiblePrimeSubsequence(int[] nums, int k) {
        int n = nums.length;
        List<Integer> primes = getPrimesUpToMax(nums);
        Set<Integer> primeSet = new HashSet<>(primes);
        int[] dp = new int[n];
        int maxLen = 0;

        for (int i = 0; i < n; i++) {
            if (primeSet.contains(nums[i])) {
                dp[i] = 1;
                for (int j = 0; j < i; j++) {
                    if (nums[i] % nums[j] == 0 && dp[j] + 1 > dp[i]) {
                        dp[i] = dp[j] + 1;
                    }
                }
                maxLen = Math.max(maxLen, dp[i]);
            }
        }

        return maxLen;
    }

    private List<Integer> getPrimesUpToMax(int[] nums) {
        int max = Arrays.stream(nums).max().orElse(0);
        boolean[] isPrime = new boolean[max + 1];
        Arrays.fill(isPrime, true);
        isPrime[0] = isPrime[1] = false;
        for (int i = 2; i * i <= max; i++) {
            if (isPrime[i]) {
                for (int j = i * i; j <= max; j += i) {
                    isPrime[j] = false;
                }
            }
        }

        List<Integer> primes = new ArrayList<>();
        for (int i = 2; i <= max; i++) {
            if (isPrime[i]) {
                primes.add(i);
            }
        }
        return primes;
    }
}
}