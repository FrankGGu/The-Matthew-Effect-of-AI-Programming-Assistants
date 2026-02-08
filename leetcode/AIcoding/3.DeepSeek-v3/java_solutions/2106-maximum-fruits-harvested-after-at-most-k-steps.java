class Solution {
    public int maxTotalFruits(int[][] fruits, int startPos, int k) {
        int n = fruits.length;
        int[] prefixSum = new int[n + 1];
        int[] positions = new int[n];

        for (int i = 0; i < n; i++) {
            positions[i] = fruits[i][0];
            prefixSum[i + 1] = prefixSum[i] + fruits[i][1];
        }

        int maxFruits = 0;

        for (int left = 0; left < n; left++) {
            int right = findRight(positions, left, startPos, k);
            if (right != -1) {
                maxFruits = Math.max(maxFruits, prefixSum[right + 1] - prefixSum[left]);
            }
        }

        return maxFruits;
    }

    private int findRight(int[] positions, int left, int startPos, int k) {
        int low = left;
        int high = positions.length - 1;
        int res = -1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            int distance = calculateMinDistance(positions[left], positions[mid], startPos);
            if (distance <= k) {
                res = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return res;
    }

    private int calculateMinDistance(int leftPos, int rightPos, int startPos) {
        if (startPos >= leftPos && startPos <= rightPos) {
            return rightPos - leftPos + Math.min(startPos - leftPos, rightPos - startPos);
        } else if (startPos < leftPos) {
            return rightPos - startPos;
        } else {
            return startPos - leftPos;
        }
    }
}