class Solution {
    public int maxWidthRamp(int[] A) {
        int n = A.length;
        int maxWidth = 0;
        int[] minIndex = new int[n];

        minIndex[0] = 0;
        for (int i = 1; i < n; i++) {
            if (A[i] < A[minIndex[i - 1]]) {
                minIndex[i] = i;
            } else {
                minIndex[i] = minIndex[i - 1];
            }
        }

        for (int j = n - 1; j > 0; j--) {
            while (minIndex[j] < j) {
                maxWidth = Math.max(maxWidth, j - minIndex[j]);
                break;
            }
        }

        return maxWidth;
    }
}