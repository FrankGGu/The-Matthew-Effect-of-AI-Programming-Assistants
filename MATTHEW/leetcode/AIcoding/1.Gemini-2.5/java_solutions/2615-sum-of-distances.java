import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public long[] sumOfDistances(int[] nums) {
        int n = nums.length;
        long[] ans = new long[n];

        Map<Integer, List<Integer>> valToIndices = new HashMap<>();
        for (int i = 0; i < n; i++) {
            valToIndices.computeIfAbsent(nums[i], k -> new ArrayList<>()).add(i);
        }

        for (Map.Entry<Integer, List<Integer>> entry : valToIndices.entrySet()) {
            List<Integer> indices = entry.getValue();
            if (indices.size() == 1) {
                continue;
            }

            int k = indices.size();
            long[] prefixSum = new long[k];
            prefixSum[0] = indices.get(0);
            for (int j = 1; j < k; j++) {
                prefixSum[j] = prefixSum[j - 1] + indices.get(j);
            }

            for (int j = 0; j < k; j++) {
                long currentIdx = indices.get(j);

                long leftSum = (long)j * currentIdx - (j > 0 ? prefixSum[j - 1] : 0);

                long rightSum = (prefixSum[k - 1] - prefixSum[j]) - (long)(k - 1 - j) * currentIdx;

                ans[(int)currentIdx] = leftSum + rightSum;
            }
        }

        return ans;
    }
}