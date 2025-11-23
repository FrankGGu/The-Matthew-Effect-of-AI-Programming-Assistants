import java.util.ArrayList;
import java.util.List;

class Solution {
    public long minMoves(int[] nums, int k) {
        List<Integer> onesIndices = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == 1) {
                onesIndices.add(i);
            }
        }

        if (k == 1) {
            return 0;
        }

        int n = onesIndices.size();
        long[] transformedPos = new long[n];
        for (int i = 0; i < n; i++) {
            transformedPos[i] = (long)onesIndices.get(i) - i;
        }

        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + transformedPos[i];
        }

        long minSwaps = Long.MAX_VALUE;

        for (int i = 0; i <= n - k; i++) {
            int medianIdxInTransformedPos = i + (k - 1) / 2;
            long medianVal = transformedPos[medianIdxInTransformedPos];

            long leftCount = medianIdxInTransformedPos - i;
            long leftSumOfElements = prefixSum[medianIdxInTransformedPos] - prefixSum[i];
            long leftSwaps = leftCount * medianVal - leftSumOfElements;

            long rightCount = (i + k - 1) - medianIdxInTransformedPos;
            long rightSumOfElements = prefixSum[i + k] - prefixSum[medianIdxInTransformedPos + 1];
            long rightSwaps = rightSumOfElements - rightCount * medianVal;

            long currentSwaps = leftSwaps + rightSwaps;
            minSwaps = Math.min(minSwaps, currentSwaps);
        }

        return minSwaps;
    }
}