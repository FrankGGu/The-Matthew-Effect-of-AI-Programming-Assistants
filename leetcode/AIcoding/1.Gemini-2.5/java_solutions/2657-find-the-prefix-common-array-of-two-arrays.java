class Solution {
    public int[] findThePrefixCommonArray(int[] A, int[] B) {
        int n = A.length;
        int[] P = new int[n];

        boolean[] seenInA = new boolean[n + 1];
        boolean[] seenInB = new boolean[n + 1];

        int commonCount = 0;

        for (int i = 0; i < n; i++) {
            int valA = A[i];
            int valB = B[i];

            if (!seenInA[valA]) {
                seenInA[valA] = true;
                if (seenInB[valA]) {
                    commonCount++;
                }
            }

            if (!seenInB[valB]) {
                seenInB[valB] = true;
                if (seenInA[valB]) {
                    commonCount++;
                }
            }

            P[i] = commonCount;
        }

        return P;
    }
}