import java.util.Random;

class Solution {
    private int[] prefixSums;
    private int totalSum;
    private Random random;

    public Solution(int[] w) {
        int n = w.length;
        prefixSums = new int[n];
        prefixSums[0] = w[0];
        totalSum = w[0];
        random = new Random();

        for (int i = 1; i < n; i++) {
            prefixSums[i] = prefixSums[i - 1] + w[i];
            totalSum += w[i];
        }
    }

    public int pickIndex() {
        int target = random.nextInt(totalSum);
        int left = 0, right = prefixSums.length - 1;

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (prefixSums[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return left;
    }
}