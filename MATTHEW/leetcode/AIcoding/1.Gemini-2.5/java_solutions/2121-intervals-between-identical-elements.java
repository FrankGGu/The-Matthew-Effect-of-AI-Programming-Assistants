import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public long[] getIntervals(int[] arr) {
        int n = arr.length;
        long[] ans = new long[n];

        Map<Integer, List<Integer>> valToIndices = new HashMap<>();
        for (int i = 0; i < n; i++) {
            valToIndices.computeIfAbsent(arr[i], k -> new ArrayList<>()).add(i);
        }

        for (List<Integer> indices : valToIndices.values()) {
            if (indices.size() <= 1) {
                continue;
            }

            long[] prefixSums = new long[indices.size()];
            prefixSums[0] = indices.get(0);
            for (int k = 1; k < indices.size(); k++) {
                prefixSums[k] = prefixSums[k - 1] + indices.get(k);
            }

            for (int k = 0; k < indices.size(); k++) {
                long currentIdx = indices.get(k);

                // Sum of distances to elements on the left:
                // (currentIdx - p_0) + ... + (currentIdx - p_{k-1})
                // = k * currentIdx - (p_0 + ... + p_{k-1})
                long leftSum = (long) k * currentIdx - (k > 0 ? prefixSums[k - 1] : 0);

                // Sum of distances to elements on the right:
                // (p_{k+1} - currentIdx) + ... + (p_m - currentIdx)
                // = (p_{k+1} + ... + p_m) - (number of elements to the right) * currentIdx
                // Number of elements to the right is (indices.size() - 1) - k
                long rightSum = (prefixSums[indices.size() - 1] - prefixSums[k]) - (long) (indices.size() - 1 - k) * currentIdx;

                ans[(int) currentIdx] = leftSum + rightSum;
            }
        }

        return ans;
    }
}