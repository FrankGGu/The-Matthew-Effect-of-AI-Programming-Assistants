class Solution {
    public int maxAbsValExpr(int[] arr1, int[] arr2) {
        int n = arr1.length;
        int maxVal = 0;
        for (int i = 0; i < 4; i++) {
            int sign1 = (i & 1) == 0 ? 1 : -1;
            int sign2 = (i & 2) == 0 ? 1 : -1;
            int max = Integer.MIN_VALUE;
            int min = Integer.MAX_VALUE;
            for (int j = 0; j < n; j++) {
                int value = sign1 * arr1[j] + sign2 * arr2[j] + j;
                max = Math.max(max, value);
                min = Math.min(min, value);
            }
            maxVal = Math.max(maxVal, max - min);
        }
        return maxVal;
    }
}