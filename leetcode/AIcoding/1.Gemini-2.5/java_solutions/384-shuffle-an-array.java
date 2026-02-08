import java.util.Random;

class Solution {

    private final int[] original;
    private final Random rand;

    public Solution(int[] nums) {
        original = new int[nums.length];
        System.arraycopy(nums, 0, original, 0, nums.length);
        rand = new Random();
    }

    public int[] reset() {
        return original;
    }

    public int[] shuffle() {
        int[] shuffled = new int[original.length];
        System.arraycopy(original, 0, shuffled, 0, original.length);

        for (int i = 0; i < shuffled.length; i++) {
            int r = i + rand.nextInt(shuffled.length - i);
            int temp = shuffled[i];
            shuffled[i] = shuffled[r];
            shuffled[r] = temp;
        }
        return shuffled;
    }
}