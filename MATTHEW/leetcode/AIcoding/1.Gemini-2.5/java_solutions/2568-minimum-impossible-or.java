import java.util.Arrays;

class Solution {
    public int minImpossibleOR(int[] nums) {
        Arrays.sort(nums);

        int currentORSum = 0;

        for (int num : nums) {
            if (num > currentORSum + 1) {
                return currentORSum + 1;
            }
            currentORSum |= num;
        }

        return currentORSum + 1;
    }
}