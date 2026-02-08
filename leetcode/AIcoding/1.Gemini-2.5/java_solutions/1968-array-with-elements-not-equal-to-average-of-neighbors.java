import java.util.Arrays;

class Solution {
    public int[] rearrangeArray(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int[] result = new int[n];
        int left = 0;
        int right = n - 1;
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                result[i] = nums[left];
                left++;
            } else {
                result[i] = nums[right];
                right--;
            }
        }
        return result;
    }
}