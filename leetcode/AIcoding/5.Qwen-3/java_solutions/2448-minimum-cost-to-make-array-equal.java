public class Solution {

import java.util.*;

public class Solution {
    public long minCostToMakeEqual(int n, int[] nums, int[] cost) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        List<int[]> sorted = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : freq.entrySet()) {
            sorted.add(new int[]{entry.getKey(), entry.getValue()});
        }

        sorted.sort((a, b) -> a[0] - b[0]);

        long[] prefixSum = new long[sorted.size()];
        long[] prefixFreq = new long[sorted.size()];
        prefixSum[0] = (long) sorted.get(0)[1] * cost[0];
        prefixFreq[0] = sorted.get(0)[1];

        for (int i = 1; i < sorted.size(); i++) {
            prefixSum[i] = prefixSum[i - 1] + (long) sorted.get(i)[1] * cost[i];
            prefixFreq[i] = prefixFreq[i - 1] + sorted.get(i)[1];
        }

        long minCost = Long.MAX_VALUE;
        for (int i = 0; i < sorted.size(); i++) {
            long leftCost = 0;
            long rightCost = 0;

            if (i > 0) {
                long leftTotalFreq = prefixFreq[i - 1];
                long leftTotalCost = prefixSum[i - 1];
                leftCost = leftTotalCost - (long) sorted.get(i)[0] * leftTotalFreq;
            }

            if (i < sorted.size() - 1) {
                long rightTotalFreq = prefixFreq[sorted.size() - 1] - prefixFreq[i];
                long rightTotalCost = prefixSum[sorted.size() - 1] - prefixSum[i];
                rightCost = (long) sorted.get(i)[0] * rightTotalFreq - rightTotalCost;
            }

            long totalCost = leftCost + rightCost;
            minCost = Math.min(minCost, totalCost);
        }

        return minCost;
    }
}
}