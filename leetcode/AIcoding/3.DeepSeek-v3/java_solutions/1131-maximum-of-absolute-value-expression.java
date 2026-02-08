class Solution {
    public int maxAbsValExpr(int[] arr1, int[] arr2) {
        int n = arr1.length;
        int max1 = Integer.MIN_VALUE, max2 = Integer.MIN_VALUE, max3 = Integer.MIN_VALUE, max4 = Integer.MIN_VALUE;
        int min1 = Integer.MAX_VALUE, min2 = Integer.MAX_VALUE, min3 = Integer.MAX_VALUE, min4 = Integer.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            max1 = Math.max(max1, arr1[i] + arr2[i] + i);
            min1 = Math.min(min1, arr1[i] + arr2[i] + i);

            max2 = Math.max(max2, arr1[i] + arr2[i] - i);
            min2 = Math.min(min2, arr1[i] + arr2[i] - i);

            max3 = Math.max(max3, arr1[i] - arr2[i] + i);
            min3 = Math.min(min3, arr1[i] - arr2[i] + i);

            max4 = Math.max(max4, arr1[i] - arr2[i] - i);
            min4 = Math.min(min4, arr1[i] - arr2[i] - i);
        }

        int diff1 = max1 - min1;
        int diff2 = max2 - min2;
        int diff3 = max3 - min3;
        int diff4 = max4 - min4;

        return Math.max(Math.max(diff1, diff2), Math.max(diff3, diff4));
    }
}