import java.util.Arrays;

class Solution {
    public int maximizeGreatness(int[] nums) {
        Arrays.sort(nums);
        int greatness = 0;
        for (int num : nums) {
            if (num > greatness) {
                greatness++;
            }
        }
        return greatness;
    }
}