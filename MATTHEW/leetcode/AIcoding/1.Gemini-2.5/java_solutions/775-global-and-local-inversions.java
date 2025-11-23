class Solution {
    public boolean isIdealPermutation(int[] A) {
        int n = A.length;
        if (n <= 2) {
            return true;
        }

        int[] minSuffix = new int[n];
        minSuffix[n - 1] = A[n - 1];
        for (int k = n - 2; k >= 0; k--) {
            minSuffix[k] = Math.min(A[k], minSuffix[k + 1]);
        }

        for (int i = 0; i <= n - 3; i++) {
            if (A[i] > minSuffix[i + 2]) {
                return false;
            }
        }

        return true;
    }
}