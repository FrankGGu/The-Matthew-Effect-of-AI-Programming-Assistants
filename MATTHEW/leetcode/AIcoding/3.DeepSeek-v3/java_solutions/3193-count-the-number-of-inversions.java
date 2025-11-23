class Solution {
    public int countInversions(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }
        int[] temp = new int[nums.length];
        return mergeSortAndCount(nums, temp, 0, nums.length - 1);
    }

    private int mergeSortAndCount(int[] nums, int[] temp, int left, int right) {
        int count = 0;
        if (left < right) {
            int mid = left + (right - left) / 2;
            count += mergeSortAndCount(nums, temp, left, mid);
            count += mergeSortAndCount(nums, temp, mid + 1, right);
            count += mergeAndCount(nums, temp, left, mid, right);
        }
        return count;
    }

    private int mergeAndCount(int[] nums, int[] temp, int left, int mid, int right) {
        for (int i = left; i <= right; i++) {
            temp[i] = nums[i];
        }
        int i = left;
        int j = mid + 1;
        int k = left;
        int count = 0;
        while (i <= mid && j <= right) {
            if (temp[i] <= temp[j]) {
                nums[k++] = temp[i++];
            } else {
                nums[k++] = temp[j++];
                count += (mid - i + 1);
            }
        }
        while (i <= mid) {
            nums[k++] = temp[i++];
        }
        while (j <= right) {
            nums[k++] = temp[j++];
        }
        return count;
    }
}