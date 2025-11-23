class Solution {
    public int maxNonDecreasingLength(int[] A, int[] B) {
        int n = A.length;
        int maxLength = 1;
        int[] dpA = new int[n];
        int[] dpB = new int[n];

        dpA[0] = 1;
        dpB[0] = 1;

        for (int i = 1; i < n; i++) {
            if (A[i] >= A[i - 1]) {
                dpA[i] = dpA[i - 1] + 1;
            } else {
                dpA[i] = 1;
            }
            if (B[i] >= B[i - 1]) {
                dpB[i] = dpB[i - 1] + 1;
            } else {
                dpB[i] = 1;
            }

            if (A[i] >= B[i - 1]) {
                dpA[i] = Math.max(dpA[i], dpB[i - 1] + 1);
            }
            if (B[i] >= A[i - 1]) {
                dpB[i] = Math.max(dpB[i], dpA[i - 1] + 1);
            }

            maxLength = Math.max(maxLength, Math.max(dpA[i], dpB[i]));
        }

        return maxLength;
    }
}