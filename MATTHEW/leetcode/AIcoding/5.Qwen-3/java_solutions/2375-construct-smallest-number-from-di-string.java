public class Solution {
    public String findMinNumber(String s) {
        StringBuilder result = new StringBuilder();
        int[] nums = new int[s.length() + 1];
        for (int i = 0; i <= s.length(); i++) {
            nums[i] = i + 1;
        }
        int i = 0;
        while (i < s.length()) {
            if (s.charAt(i) == 'D') {
                int j = i;
                while (j < s.length() && s.charAt(j) == 'D') {
                    j++;
                }
                reverse(nums, i, j);
                i = j;
            } else {
                i++;
            }
        }
        for (int num : nums) {
            result.append(num);
        }
        return result.toString();
    }

    private void reverse(int[] nums, int start, int end) {
        while (start < end) {
            int temp = nums[start];
            nums[start] = nums[end];
            nums[end] = temp;
            start++;
            end--;
        }
    }
}