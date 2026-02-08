class Solution {
    public int largestOutlier(int[] arr) {
        int n = arr.length;
        if (n < 3) return -1;

        int[] outliers = new int[n];
        int outlierCount = 0;

        for (int num : arr) {
            if (isOutlier(num, arr)) {
                outliers[outlierCount++] = num;
            }
        }

        int largest = Integer.MIN_VALUE;
        for (int i = 0; i < outlierCount; i++) {
            largest = Math.max(largest, outliers[i]);
        }
        return largest == Integer.MIN_VALUE ? -1 : largest;
    }

    private boolean isOutlier(int num, int[] arr) {
        int count = 0;
        for (int n : arr) {
            if (n != num) {
                count++;
            }
        }
        return count < arr.length - 2;
    }
}