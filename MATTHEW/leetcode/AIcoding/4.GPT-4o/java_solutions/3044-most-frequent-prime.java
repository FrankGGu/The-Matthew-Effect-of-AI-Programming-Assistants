import java.util.*;

class Solution {
    public int mostFrequentPrime(int[] nums) {
        Map<Integer, Integer> primeCount = new HashMap<>();
        for (int num : nums) {
            if (num > 1 && isPrime(num)) {
                primeCount.put(num, primeCount.getOrDefault(num, 0) + 1);
            }
        }

        int maxCount = 0;
        int result = -1;
        for (Map.Entry<Integer, Integer> entry : primeCount.entrySet()) {
            if (entry.getValue() > maxCount || (entry.getValue() == maxCount && entry.getKey() < result)) {
                maxCount = entry.getValue();
                result = entry.getKey();
            }
        }

        return result;
    }

    private boolean isPrime(int num) {
        if (num < 2) return false;
        for (int i = 2; i * i <= num; i++) {
            if (num % i == 0) return false;
        }
        return true;
    }
}