import java.util.Random;
import java.util.Arrays;

class Solution {
    private int[] prefixSums;
    private int totalSum;
    private Random rand;

    public Solution(int[] w) {
        this.rand = new Random();
        this.prefixSums = new int[w.length];
        this.totalSum = 0;

        for (int i = 0; i < w.length; i++) {
            totalSum += w[i];
            prefixSums[i] = totalSum;
        }
    }

    public int pickIndex() {
        int target = rand.nextInt(totalSum); 

        int idx = Arrays.binarySearch(prefixSums, target + 1);

        if (idx < 0) {
            idx = -(idx + 1);
        }

        return idx;
    }
}