public class Solution {
    public int maximumRemovableChars(int[] nums, int[] target) {
        int i = 0;
        int j = 0;
        while (i < nums.length && j < target.length) {
            if (nums[i] == target[j]) {
                j++;
            }
            i++;
        }
        return j;
    }
}