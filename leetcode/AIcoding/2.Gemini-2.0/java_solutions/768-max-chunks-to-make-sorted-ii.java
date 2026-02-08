class Solution {
    public int maxChunksToSorted(int[] arr) {
        int n = arr.length;
        long[] leftMax = new long[n];
        long[] rightMin = new long[n];

        leftMax[0] = arr[0];
        for (int i = 1; i < n; i++) {
            leftMax[i] = Math.max(leftMax[i - 1], arr[i]);
        }

        rightMin[n - 1] = arr[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            rightMin[i] = Math.min(rightMin[i + 1], arr[i]);
        }

        int count = 1;
        for (int i = 0; i < n - 1; i++) {
            if (leftMax[i] <= rightMin[i + 1]) {
                count++;
            }
        }

        return count;
    }
}