import java.util.*;

class Solution {
    public int maxDistinctPrimeFactors(int[] nums) {
        int n = nums.length;
        int ans = 0;
        Set<Integer> seen = new HashSet<>();
        for (int num : nums) {
            Set<Integer> primes = new HashSet<>();
            int temp = num;
            for (int i = 2; i * i <= temp; i++) {
                while (temp % i == 0) {
                    primes.add(i);
                    temp /= i;
                }
            }
            if (temp > 1) {
                primes.add(temp);
            }
            for (int prime : primes) {
                if (!seen.contains(prime)) {
                    seen.add(prime);
                    ans++;
                }
            }
        }
        return ans;
    }
}