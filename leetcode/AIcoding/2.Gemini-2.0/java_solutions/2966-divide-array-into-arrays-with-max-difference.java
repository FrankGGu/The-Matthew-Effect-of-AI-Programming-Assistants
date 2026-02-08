import java.util.Arrays;

class Solution {
    public int[][] divideArray(int[] nums, int k) {
        Arrays.sort(nums);
        int n = nums.length;
        int[][] result = new int[n / 3][3];
        int index = 0;
        for (int i = 0; i < n; i += 3) {
            if (nums[i + 2] - nums[i] > k) {
                return new int[0][0];
            }
            result[index][0] = nums[i];
            result[index][1] = nums[i + 1];
            result[index][2] = nums[i + 2];
            index++;
        }
        return result;
    }
}