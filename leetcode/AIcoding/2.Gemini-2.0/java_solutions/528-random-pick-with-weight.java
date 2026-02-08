import java.util.Random;

class Solution {

    private int[] prefixSums;
    private int totalSum;
    private Random random;

    public Solution(int[] w) {
        prefixSums = new int[w.length];
        totalSum = 0;
        for (int i = 0; i < w.length; i++) {
            totalSum += w[i];
            prefixSums[i] = totalSum;
        }
        random = new Random();
    }

    public int pickIndex() {
        int target = random.nextInt(totalSum) + 1;
        int low = 0;
        int high = prefixSums.length - 1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (prefixSums[mid] < target) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return low;
    }
}