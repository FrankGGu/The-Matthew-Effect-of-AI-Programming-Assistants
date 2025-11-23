import java.util.Random;

class Solution {
    private int[] original;
    private int[] array;
    private Random rand;

    public Solution(int[] nums) {
        original = nums.clone();
        array = nums.clone();
        rand = new Random();
    }

    public int[] reset() {
        array = original.clone();
        return array;
    }

    public int[] shuffle() {
        for (int i = 0; i < array.length; i++) {
            int j = rand.nextInt(array.length - i) + i;
            int temp = array[i];
            array[i] = array[j];
            array[j] = temp;
        }
        return array;
    }
}