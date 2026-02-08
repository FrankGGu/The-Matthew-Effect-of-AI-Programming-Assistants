class Solution {
    public int[] pivotArray(int[] nums, int pivot) {
        int n = nums.length;
        int[] result = new int[n];
        int k = 0;

        for (int i = 0; i < n; i++) {
            if (nums[i] < pivot) {
                result[k++] = nums[i];
            }
        }

        for (int i = 0; i < n; i++) {
            if (nums[i] == pivot) {
                result[k++] = nums[i];
            }
        }

        for (int i = 0; i < n; i++) {
            if (nums[i] > pivot) {
                result[k++] = nums[i];
            }
        }

        return result;
    }
}