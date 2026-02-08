import java.util.*;

public class Solution {
    public int maximizeDistinctPrimes(int[] nums) {
        Set<Integer> primeSet = new HashSet<>();
        for (int num : nums) {
            if (num > 1 && isPrime(num)) {
                primeSet.add(num);
            }
        }
        int distinctPrimes = primeSet.size();
        return distinctPrimes;
    }

    private boolean isPrime(int num) {
        if (num < 2) return false;
        for (int i = 2; i <= Math.sqrt(num); i++) {
            if (num % i == 0) return false;
        }
        return true;
    }
}