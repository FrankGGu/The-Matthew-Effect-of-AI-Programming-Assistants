public class Solution {

import java.util.*;

public class Solution {
    public int distinctPrimeFactors(int[] nums) {
        Set<Integer> primes = new HashSet<>();
        for (int num : nums) {
            int n = num;
            for (int i = 2; i * i <= n; i++) {
                if (n % i == 0) {
                    primes.add(i);
                    while (n % i == 0) {
                        n /= i;
                    }
                }
            }
            if (n > 1) {
                primes.add(n);
            }
        }
        return primes.size();
    }
}
}