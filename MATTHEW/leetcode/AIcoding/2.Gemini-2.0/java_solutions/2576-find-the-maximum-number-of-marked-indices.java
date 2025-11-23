import java.util.Arrays;

class Solution {
    public int maxNumOfMarkedIndices(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int left = 0;
        int right = (n + 1) / 2;
        int count = 0;
        while (left < n / 2 && right < n) {
            if (2 * nums[left] <= nums[right]) {
                count += 2;
                left++;
                right++;
            } else {
                right++;
            }
        }
        return count;
    }
}