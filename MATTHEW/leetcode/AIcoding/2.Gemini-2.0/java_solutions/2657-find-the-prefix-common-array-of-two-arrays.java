class Solution {
    public int[] findThePrefixCommonArray(int[] A, int[] B) {
        int n = A.length;
        int[] C = new int[n];
        for (int i = 0; i < n; i++) {
            int count = 0;
            boolean[] seenA = new boolean[n + 1];
            boolean[] seenB = new boolean[n + 1];
            for (int j = 0; j <= i; j++) {
                seenA[A[j]] = true;
                seenB[B[j]] = true;
            }
            for (int k = 1; k <= n; k++) {
                if (seenA[k] && seenB[k]) {
                    count++;
                }
            }
            C[i] = count;
        }
        return C;
    }
}