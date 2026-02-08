class Solution {
    private long mergeAndCount(int[] nums, int left, int mid, int right) {
        int[] temp = new int[right - left + 1];
        int i = left, j = mid + 1, k = 0;
        long inversions = 0;

        while (i <= mid && j <= right) {
            if (nums[i] <= nums[j]) {
                temp[k++] = nums[i++];
            } else {
                temp[k++] = nums[j++];
                inversions += (mid - i + 1);
            }
        }

        while (i <= mid) {
            temp[k++] = nums[i++];
        }

        while (j <= right) {
            temp[k++] = nums[j++];
        }

        System.arraycopy(temp, 0, nums, left, temp.length);
        return inversions;
    }

    private long mergeSortAndCount(int[] nums, int left, int right) {
        if (left >= right) {
            return 0;
        }

        int mid = (left + right) / 2;
        long inversions = mergeSortAndCount(nums, left, mid);
        inversions += mergeSortAndCount(nums, mid + 1, right);
        inversions += mergeAndCount(nums, left, mid, right);
        return inversions;
    }

    public long reversePairs(int[] nums) {
        return mergeSortAndCount(nums, 0, nums.length - 1);
    }
}