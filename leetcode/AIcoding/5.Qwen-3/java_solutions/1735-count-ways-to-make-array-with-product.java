public class Solution {

import java.util.*;

public class Solution {
    public int waysToMakeArray(int n, int[] q) {
        int MOD = 1000000007;
        Map<Integer, Integer> primeCount = new HashMap<>();
        for (int num : q) {
            for (int i = 2; i * i <= num; i++) {
                while (num % i == 0) {
                    primeCount.put(i, primeCount.getOrDefault(i, 0) + 1);
                    num /= i;
                }
            }
            if (num > 1) {
                primeCount.put(num, primeCount.getOrDefault(num, 0) + 1);
            }
        }

        long result = 1;
        for (Map.Entry<Integer, Integer> entry : primeCount.entrySet()) {
            int count = entry.getValue();
            long ways = 1;
            for (int i = 1; i <= n - 1; i++) {
                ways = (ways * (count + i - 1)) / i;
            }
            result = (result * ways) % MOD;
        }

        return (int) result;
    }
}
}