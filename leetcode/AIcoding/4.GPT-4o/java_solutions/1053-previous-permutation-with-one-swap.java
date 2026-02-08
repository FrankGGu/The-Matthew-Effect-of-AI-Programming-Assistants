class Solution {
    public int[] prevPermOpt1(int[] A) {
        int n = A.length;
        int idx1 = -1, idx2 = -1;

        for (int i = n - 2; i >= 0; i--) {
            if (A[i] > A[i + 1]) {
                idx1 = i;
                break;
            }
        }

        if (idx1 == -1) return A;

        for (int i = n - 1; i > idx1; i--) {
            if (A[i] < A[idx1]) {
                if (idx2 == -1 || A[i] > A[idx2]) {
                    idx2 = i;
                }
            }
        }

        int temp = A[idx1];
        A[idx1] = A[idx2];
        A[idx2] = temp;

        return A;
    }
}