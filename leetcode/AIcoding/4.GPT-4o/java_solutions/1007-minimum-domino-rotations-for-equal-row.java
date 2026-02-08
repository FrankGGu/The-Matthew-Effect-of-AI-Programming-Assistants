class Solution {
    public int minDominoRotations(int[] A, int[] B) {
        int res = Math.min(check(A[0], A, B), check(B[0], A, B));
        return res == Integer.MAX_VALUE ? -1 : res;
    }

    private int check(int x, int[] A, int[] B) {
        int swapA = 0, swapB = 0;
        for (int i = 0; i < A.length; i++) {
            if (A[i] != x && B[i] != x) return Integer.MAX_VALUE;
            if (A[i] != x) swapA++;
            if (B[i] != x) swapB++;
        }
        return Math.min(swapA, swapB);
    }
}