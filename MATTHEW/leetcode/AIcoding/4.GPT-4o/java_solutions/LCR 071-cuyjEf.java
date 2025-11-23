import java.util.Random;

class Solution {
    private int[] prefixSums;
    private int totalWeight;
    private Random random;

    public Solution(int[] w) {
        prefixSums = new int[w.length];
        totalWeight = 0;
        random = new Random();
        for (int i = 0; i < w.length; i++) {
            totalWeight += w[i];
            prefixSums[i] = totalWeight;
        }
    }

    public int pickIndex() {
        int target = random.nextInt(totalWeight);
        int left = 0, right = prefixSums.length - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (prefixSums[mid] > target) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
}