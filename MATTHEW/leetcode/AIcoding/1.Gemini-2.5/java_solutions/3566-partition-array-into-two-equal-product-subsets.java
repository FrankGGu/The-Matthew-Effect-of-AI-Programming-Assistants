import java.util.HashMap;
import java.util.Map;

class Solution {

    private Map<Integer, Integer> getPrimeFactorization(int val, int[] negativeCountHolder) {
        Map<Integer, Integer> factors = new HashMap<>();

        if (val == 0) {
            return factors;
        }

        long num = val; 
        if (num < 0) {
            negativeCountHolder[0]++;
            num = -num;
        }

        for (int i = 2; (long)i * i <= num; i++) {
            while (num % i == 0) {
                factors.put(i, factors.getOrDefault(i, 0) + 1);
                num /= i;
            }
        }
        if (num > 1) { 
            factors.put((int)num, factors.getOrDefault((int)num, 0) + 1);
        }
        return factors;
    }

    private void addPrimeFactors(Map<Integer, Integer> target, Map<Integer, Integer> source) {
        for (Map.Entry<Integer, Integer> entry : source.entrySet()) {
            target.put(entry.getKey(), target.getOrDefault(entry.getKey(), 0) + entry.getValue());
        }
    }

    private void subtractPrimeFactors(Map<Integer, Integer> target, Map<Integer, Integer> source) {
        for (Map.Entry<Integer, Integer> entry : source.entrySet()) {
            target.put(entry.getKey(), target.get(entry.getKey()) - entry.getValue());
            if (target.get(entry.getKey()) == 0) {
                target.remove(entry.getKey());
            }
        }
    }

    private boolean areMapsEqual(Map<Integer, Integer> map1, Map<Integer, Integer> map2) {
        if (map1.size() != map2.size()) {
            return false;
        }
        for (Map.Entry<Integer, Integer> entry : map1.entrySet()) {
            if (!map2.containsKey(entry.getKey()) || !map2.get(entry.getKey()).equals(entry.getValue())) {
                return false;
            }
        }
        return true;
    }

    public boolean canPartition(int[] nums) {
        int n = nums.length;
        if (n < 2) {
            return false;
        }

        int zeroCount = 0;
        for (int num : nums) {
            if (num == 0) {
                zeroCount++;
            }
        }

        if (zeroCount >= 2) {
            return true;
        }

        if (zeroCount == 1) {
            return false;
        }

        Map<Integer, Integer> totalPrimeCounts = new HashMap<>();
        int[] totalNegativeCount = new int[]{0}; 

        for (int num : nums) {
            Map<Integer, Integer> factors = getPrimeFactorization(num, totalNegativeCount);
            addPrimeFactors(totalPrimeCounts, factors);
        }

        if (totalNegativeCount[0] % 2 != 0) {
            return false;
        }

        Map<Integer, Integer> leftPrimeCounts = new HashMap<>();
        int[] leftNegativeCount = new int[]{0};

        for (int i = 0; i < n - 1; i++) {
            Map<Integer, Integer> currentNumFactors = getPrimeFactorization(nums[i], leftNegativeCount);
            addPrimeFactors(leftPrimeCounts, currentNumFactors);

            Map<Integer, Integer> rightPrimeCounts = new HashMap<>(totalPrimeCounts); 
            int rightNegativeCount = totalNegativeCount[0] - leftNegativeCount[0];
            subtractPrimeFactors(rightPrimeCounts, leftPrimeCounts); 

            if ((leftNegativeCount[0] % 2) == (rightNegativeCount % 2)) {
                if (areMapsEqual(leftPrimeCounts, rightPrimeCounts)) {
                    return true;
                }
            }
        }

        return false;
    }
}