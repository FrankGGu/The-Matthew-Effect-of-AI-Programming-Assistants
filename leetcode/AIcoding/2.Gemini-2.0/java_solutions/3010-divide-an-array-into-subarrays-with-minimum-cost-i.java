import java.util.Arrays;

class Solution {
    public int minimumCost(int[] nums) {
        int n = nums.length;
        int[] arr = new int[n - 1];
        for (int i = 1; i < n; i++) {
            arr[i - 1] = nums[i];
        }
        Arrays.sort(arr);
        return nums[0] + arr[0] + arr[1];
    }
}