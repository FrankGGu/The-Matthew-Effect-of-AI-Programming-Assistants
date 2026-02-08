class Solution {
    public int smallestRangeI(int[] A, int K) {
        int minVal = A[0];
        int maxVal = A[0];

        for (int i = 1; i < A.length; i++) {
            if (A[i] < minVal) {
                minVal = A[i];
            }
            if (A[i] > maxVal) {
                maxVal = A[i];
            }
        }

        return Math.max(0, maxVal - minVal - 2 * K);
    }
}