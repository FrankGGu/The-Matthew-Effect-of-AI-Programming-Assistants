import java.util.*;

class Solution {
    public boolean primeSubOperation(int[] nums) {
        int n = nums.length;
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

        List<Integer> primes = new ArrayList<>();
        for (int i = 2; i <= 1000; i++) {
            if (isPrime[i]) {
                primes.add(i);
            }
        }

        for (int i = n - 1; i > 0; i--) {
            if (nums[i] <= nums[i - 1]) {
                boolean subtracted = false;
                for (int prime : primes) {
                    if (nums[i - 1] - prime > nums[i]) {
                        nums[i - 1] -= prime;
                        subtracted = true;
                        break;
                    }
                }
                if (!subtracted) return false;
            }
        }
        return true;
    }
}