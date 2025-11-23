class Solution {
    public int countMonotonicPairs(int[] nums) {
        int n = nums.length;
        int[] temp = new int[n];
        return mergeSortAndCount(nums, temp, 0, n - 1);
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
        int i = left;
        int j = mid + 1;
        int k = left;
        int count = 0;

        while (i <= mid && j <= right) {
            if (nums[i] <= nums[j]) {
                temp[k++] = nums[i++];
            } else {
                temp[k++] = nums[j++];
                count += mid - i + 1;
            }
        }

        while (i <= mid) {
            temp[k++] = nums[i++];
        }

        while (j <= right) {
            temp[k++] = nums[j++];
        }

        for (i = left; i <= right; i++) {
            nums[i] = temp[i];
        }

        return count;
    }
}