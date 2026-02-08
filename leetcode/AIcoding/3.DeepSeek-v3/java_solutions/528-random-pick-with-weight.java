class Solution {
    private int[] prefixSums;
    private int totalSum;

    public Solution(int[] w) {
        prefixSums = new int[w.length];
        int prefixSum = 0;
        for (int i = 0; i < w.length; ++i) {
            prefixSum += w[i];
            prefixSums[i] = prefixSum;
        }
        totalSum = prefixSum;
    }

    public int pickIndex() {
        double target = totalSum * Math.random();
        int left = 0, right = prefixSums.length - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (target > prefixSums[mid]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
}