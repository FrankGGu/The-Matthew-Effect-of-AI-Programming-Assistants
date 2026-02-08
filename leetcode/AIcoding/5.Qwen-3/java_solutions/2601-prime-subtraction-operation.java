public class Solution {

import java.util.*;

public class Solution {
    public boolean primeSubtractionOperation(int[] nums) {
        int n = nums.length;
        List<Integer> primes = new ArrayList<>();
        boolean[] isPrime = new boolean[1001];
        Arrays.fill(isPrime, true);
        isPrime[0] = isPrime[1] = false;
        for (int i = 2; i * i <= 1000; i++) {
            if (isPrime[i]) {
                for (int j = i * i; j <= 1000; j += i) {
                    isPrime[j] = false;
                }
            }
        }
        for (int i = 2; i <= 1000; i++) {
            if (isPrime[i]) {
                primes.add(i);
            }
        }
        for (int i = 0; i < n - 1; i++) {
            int target = nums[i + 1] - nums[i];
            boolean found = false;
            for (int p : primes) {
                if (p > target) break;
                if (nums[i] - p < nums[i + 1]) {
                    found = true;
                    break;
                }
            }
            if (!found) return false;
        }
        return true;
    }
}
}