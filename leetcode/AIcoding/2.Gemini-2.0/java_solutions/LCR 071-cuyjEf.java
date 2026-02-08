class Solution {
    private int[] prefixSums;
    private int totalSum;

    public Solution(int[] w) {
        prefixSums = new int[w.length];
        totalSum = 0;
        for (int i = 0; i < w.length; ++i) {
            totalSum += w[i];
            prefixSums[i] = totalSum;
        }
    }

    public int pickIndex() {
        double target = totalSum * Math.random();
        int low = 0;
        int high = prefixSums.length;
        while (low < high) {
            int mid = low + (high - low) / 2;
            if (target > prefixSums[mid]) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }
}