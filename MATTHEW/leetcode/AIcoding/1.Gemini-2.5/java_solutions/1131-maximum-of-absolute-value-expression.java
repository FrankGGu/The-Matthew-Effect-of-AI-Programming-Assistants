class Solution {
    public int maxAbsValExpr(int[] arr1, int[] arr2) {
        int n = arr1.length;
        int maxVal = 0;

        // Iterate through all 8 combinations of signs for arr1[i], arr2[i], and i
        // This covers all possible ways to open the absolute values.
        // For each combination of signs (s1, s2, s3), we want to maximize:
        // (s1*arr1[i] + s2*arr2[i] + s3*i) - (s1*arr1[j] + s2*arr2[j] + s3*j)
        // This is equivalent to finding max(val_k(i)) - min(val_k(i))
        // where val_k(i) = s1*arr1[i] + s2*arr2[i] + s3*i

        int[] s1_options = {-1, 1};
        int[] s2_options = {-1, 1};
        int[] s3_options = {-1, 1};

        for (int s1 : s1_options) {
            for (int s2 : s2_options) {
                for (int s3 : s3_options) {
                    int currentMin = Integer.MAX_VALUE;
                    int currentMax = Integer.MIN_VALUE;

                    for (int i = 0; i < n; i++) {
                        int val = s1 * arr1[i] + s2 * arr2[i] + s3 * i;
                        currentMin = Math.min(currentMin, val);
                        currentMax = Math.max(currentMax, val);
                    }
                    maxVal = Math.max(maxVal, currentMax - currentMin);
                }
            }
        }

        return maxVal;
    }
}