class Solution {
    public int[] findThePrefixCommonArray(int[] A, int[] B) {
        int n = A.length;
        int[] result = new int[n];
        int countA = 0, countB = 0;

        for (int i = 0; i < n; i++) {
            countA += (i == 0 || A[i] == A[i - 1]) ? 1 : 0;
            countB += (i == 0 || B[i] == B[i - 1]) ? 1 : 0;
            result[i] = Math.min(countA, countB);
        }

        return result;
    }
}