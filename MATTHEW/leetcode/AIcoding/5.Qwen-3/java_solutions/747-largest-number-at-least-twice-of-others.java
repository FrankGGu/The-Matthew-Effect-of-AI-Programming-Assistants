public class Solution {
    public String largestNumber(int[] nums) {
        int maxIndex = 0;
        for (int i = 1; i < nums.length; i++) {
            if (nums[i] > nums[maxIndex]) {
                maxIndex = i;
            }
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < nums.length; i++) {
            if (i != maxIndex && nums[maxIndex] < nums[i] * 2) {
                return "0";
            }
        }
        for (int num : nums) {
            sb.append(num);
        }
        return sb.toString();
    }
}