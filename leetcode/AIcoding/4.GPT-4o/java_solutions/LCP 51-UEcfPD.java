class Solution {
    public int cookMeals(int[] A, int[] B, int[] C) {
        int n = A.length;
        int m = B.length;
        int result = 0;

        for (int i = 0; i < n; i++) {
            int maxCook = C[i] / A[i];
            for (int j = 0; j < m; j++) {
                if (B[j] >= maxCook) {
                    result += maxCook;
                    B[j] -= maxCook;
                    break;
                }
            }
        }

        return result;
    }
}