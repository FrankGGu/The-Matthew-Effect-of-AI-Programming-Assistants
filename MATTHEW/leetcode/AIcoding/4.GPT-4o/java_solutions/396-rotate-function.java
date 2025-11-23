class Solution {
    public int maxRotateFunction(int[] A) {
        int n = A.length;
        if (n == 0) return 0;

        int F = 0, sum = 0;
        for (int i = 0; i < n; i++) {
            F += i * A[i];
            sum += A[i];
        }

        int maxF = F;
        for (int i = 1; i < n; i++) {
            F = F + sum - n * A[n - i];
            maxF = Math.max(maxF, F);
        }

        return maxF;
    }
}