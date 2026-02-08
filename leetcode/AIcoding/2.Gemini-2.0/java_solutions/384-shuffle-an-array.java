import java.util.Random;

class Solution {

    private int[] nums;
    private int[] original;
    private Random rand;

    public Solution(int[] nums) {
        this.nums = nums;
        this.original = nums.clone();
        this.rand = new Random();
    }

    public int[] reset() {
        nums = original.clone();
        return nums;
    }

    public int[] shuffle() {
        for (int i = 0; i < nums.length; i++) {
            int j = rand.nextInt(nums.length);
            int temp = nums[i];
            nums[i] = nums[j];
            nums[j] = temp;
        }
        return nums;
    }
}