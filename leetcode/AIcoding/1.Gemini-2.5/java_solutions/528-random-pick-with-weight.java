import java.util.Random;
import java.util.Arrays;

class Solution {

    private int[] prefixSums;
    private Random random;
    private int totalSum;

    public Solution(int[] w) {
        this.random = new Random();
        this.prefixSums = new int[w.length];

        int currentSum = 0;
        for (int i = 0; i < w.length; i++) {
            currentSum += w[i];
            this.prefixSums[i] = currentSum;
        }
        this.totalSum = currentSum;
    }

    public int pickIndex() {
        int target = random.nextInt(totalSum) + 1;

        int index = Arrays.binarySearch(prefixSums, target);

        return index >= 0 ? index : -index - 1;
    }
}