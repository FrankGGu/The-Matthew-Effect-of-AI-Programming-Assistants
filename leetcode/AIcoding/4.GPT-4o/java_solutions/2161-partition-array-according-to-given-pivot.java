class Solution {
    public int[] pivotArray(int[] nums, int pivot) {
        int n = nums.length;
        int[] result = new int[n];
        int left = 0, right = n - 1;

        for (int num : nums) {
            if (num < pivot) {
                result[left++] = num;
            } else if (num > pivot) {
                result[right--] = num;
            }
        }

        for (int i = left; i <= right; i++) {
            result[i] = pivot;
        }

        return result;
    }
}