import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {

    private static final int MAX_VAL = 1_000_000;
    private static int[] spf = new int[MAX_VAL + 1]; // Smallest Prime Factor

    static {
        for (int i = 2; i <= MAX_VAL; i++) {
            spf[i] = i;
        }

        for (int i = 2; i * i <= MAX_VAL; i++) {
            if (spf[i] == i) {
                for (int j = i * i; j <= MAX_VAL; j += i) {
                    if (spf[j] == j) {
                        spf[j] = i;
                    }
                }
            }
        }
    }

    private List<Integer> getDistinctPrimeFactors(int n) {
        List<Integer> factors = new ArrayList<>();
        if (n <= 1) return factors;
        while (n > 1) {
            int p = spf[n];
            factors.add(p);
            while (n % p == 0) {
                n /= p;
            }
        }
        return factors;
    }

    public int splitArray(int[] nums) {
        int n = nums.length;

        Map<Integer, Integer> rightFactorMap = new HashMap<>();
        Map<Integer, Integer> leftFactorMap = new HashMap<>();

        int numCommonPrimes = 0;

        for (int num : nums) {
            List<Integer> pfList = getDistinctPrimeFactors(num);
            for (int p : pfList) {
                rightFactorMap.put(p, rightFactorMap.getOrDefault(p, 0) + 1);
            }
        }

        for (int i = 0; i < n - 1; i++) {
            int num = nums[i];
            List<Integer> pfList = getDistinctPrimeFactors(num);

            for (int p : pfList) {
                rightFactorMap.put(p, rightFactorMap.get(p) - 1);
                if (rightFactorMap.get(p) == 0) {
                    rightFactorMap.remove(p);
                    if (leftFactorMap.containsKey(p)) {
                        numCommonPrimes--;
                    }
                }

                if (!leftFactorMap.containsKey(p)) {
                    leftFactorMap.put(p, 1);
                    if (rightFactorMap.containsKey(p)) {
                        numCommonPrimes++;
                    }
                } else {
                    leftFactorMap.put(p, leftFactorMap.get(p) + 1);
                }
            }

            if (numCommonPrimes == 0) {
                return i;
            }
        }

        return -1;
    }
}