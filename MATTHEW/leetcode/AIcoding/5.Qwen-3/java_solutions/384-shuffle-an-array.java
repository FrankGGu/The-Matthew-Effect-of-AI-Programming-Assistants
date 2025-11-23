public class Solution {

import java.util.Random;

public class Solution {
    private int[] original;
    private Random rand;

    public Solution(int[] nums) {
        original = nums;
        rand = new Random();
    }

    public int[] reset() {
        return original;
    }

    public int[] shuffle() {
        int[] shuffled = original.clone();
        for (int i = shuffled.length - 1; i > 0; i--) {
            int j = rand.nextInt(i + 1);
            int temp = shuffled[i];
            shuffled[i] = shuffled[j];
            shuffled[j] = temp;
        }
        return shuffled;
    }
}
}