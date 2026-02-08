import java.util.ArrayList;
import java.util.List;

class Solution {
    public long minMoves(int[] nums, int k) {
        if (k == 0) {
            return 0; 
        }

        List<Integer> ones = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == 1) {
                ones.add(i);
            }
        }

        if (ones.size() < k) {
            return -1; 
        }

        List<Long> transformedOnes = new ArrayList<>();
        for (int i = 0; i < ones.size(); i++) {
            transformedOnes.add((long)ones.get(i) - i);
        }

        long[] prefixSumTransformed = new long[transformedOnes.size() + 1];
        for (int i = 0; i < transformedOnes.size(); i++) {
            prefixSumTransformed[i + 1] = prefixSumTransformed[i] + transformedOnes.get(i);
        }

        long minTotalMoves = Long.MAX_VALUE;

        for (int i = 0; i <= transformedOnes.size() - k; i++) {
            int medianIdxInTransformedOnes = i + k / 2;
            long medianVal = transformedOnes.get(medianIdxInTransformedOnes);

            long leftCount = (long)medianIdxInTransformedOnes - i + 1;
            long leftSumValues = prefixSumTransformed[medianIdxInTransformedOnes + 1] - prefixSumTransformed[i];
            long costLeft = leftCount * medianVal - leftSumValues;

            long rightCount = (long)(i + k - 1) - (medianIdxInTransformedOnes + 1) + 1;

            long costRight = 0;
            if (rightCount > 0) {
                long rightSumValues = prefixSumTransformed[i + k] - prefixSumTransformed[medianIdxInTransformedOnes + 1];
                costRight = rightSumValues - rightCount * medianVal;
            }

            long currentWindowMoves = costLeft + costRight;
            minTotalMoves = Math.min(minTotalMoves, currentWindowMoves);
        }

        return minTotalMoves;
    }
}