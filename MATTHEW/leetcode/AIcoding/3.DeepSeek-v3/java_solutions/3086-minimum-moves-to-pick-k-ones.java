class Solution {
    public long minimumMoves(int[] nums, int k, int maxChanges) {
        List<Integer> onesIndices = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == 1) {
                onesIndices.add(i);
            }
        }

        int m = onesIndices.size();
        if (m == 0) {
            return 0;
        }

        long[] prefixSum = new long[m + 1];
        for (int i = 0; i < m; i++) {
            prefixSum[i + 1] = prefixSum[i] + onesIndices.get(i);
        }

        long minMoves = Long.MAX_VALUE;
        int maxConsecutive = Math.min(k, maxChanges + 1);

        for (int consecutive = Math.max(1, k - maxChanges); consecutive <= maxConsecutive; consecutive++) {
            int changes = k - consecutive;
            if (changes < 0 || changes > maxChanges) {
                continue;
            }

            for (int left = 0; left + consecutive <= m; left++) {
                int right = left + consecutive;
                int medianPos = left + consecutive / 2;
                long median = onesIndices.get(medianPos);

                long sumLeft = median * (medianPos - left) - (prefixSum[medianPos] - prefixSum[left]);
                long sumRight = (prefixSum[right] - prefixSum[medianPos + 1]) - median * (right - medianPos - 1);
                long total = sumLeft + sumRight;

                if (changes > 0) {
                    int leftBound = left > 0 ? onesIndices.get(left - 1) + 1 : 0;
                    int rightBound = right < m ? onesIndices.get(right) - 1 : nums.length - 1;

                    int available = rightBound - leftBound + 1 - consecutive;
                    if (available >= changes) {
                        total += changes * 2;
                    } else {
                        total = Long.MAX_VALUE;
                    }
                }

                if (total < minMoves) {
                    minMoves = total;
                }
            }
        }

        return minMoves;
    }
}