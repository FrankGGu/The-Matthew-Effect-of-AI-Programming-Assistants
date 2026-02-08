class Solution {
    public int[] pivotArray(int[] nums, int pivot) {
        int n = nums.length;
        int[] ans = new int[n];
        int left = 0;
        int right = n - 1;
        int mid = 0;

        for (int i = 0; i < n; i++) {
            if (nums[i] < pivot) {
                ans[left++] = nums[i];
            } else if (nums[i] > pivot) {
                ans[right--] = nums[i];
            } else {
                mid++;
            }
        }

        while (mid > 0) {
            ans[left++] = pivot;
            mid--;
        }

        return ans;
    }
}