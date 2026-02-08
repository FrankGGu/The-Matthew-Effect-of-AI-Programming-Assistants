public class Solution {
    public int[] pivotArray(int[] nums, int pivot) {
        int n = nums.length;
        int[] result = new int[n];
        int left = 0, right = n - 1;

        for (int i = 0; i < n; i++) {
            if (nums[i] < pivot) {
                result[left++] = nums[i];
            } else if (nums[i] > pivot) {
                result[right--] = nums[i];
            }
        }

        while (left <= right) {
            result[left++] = pivot;
        }

        return result;
    }
}