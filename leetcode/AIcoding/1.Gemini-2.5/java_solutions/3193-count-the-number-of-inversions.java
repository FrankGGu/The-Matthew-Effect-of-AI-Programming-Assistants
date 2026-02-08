class Solution {
    public long countInversions(int[] nums) {
        if (nums == null || nums.length < 2) {
            return 0;
        }
        int[] temp = new int[nums.length];
        return mergeSortAndCount(nums, 0, nums.length - 1, temp);
    }

    private long mergeSortAndCount(int[] nums, int low, int high, int[] temp) {
        if (low >= high) {
            return 0;
        }

        int mid = low + (high - low) / 2;
        long inversions = 0;

        inversions += mergeSortAndCount(nums, low, mid, temp);
        inversions += mergeSortAndCount(nums, mid + 1, high, temp);
        inversions += mergeAndCountSplitInversions(nums, low, mid, high, temp);

        return inversions;
    }

    private long mergeAndCountSplitInversions(int[] nums, int low, int mid, int high, int[] temp) {
        long splitInversions = 0;

        int i = low;
        int j = mid + 1;
        int k = low;

        while (i <= mid && j <= high) {
            if (nums[i] <= nums[j]) {
                temp[k++] = nums[i++];
            } else {
                temp[k++] = nums[j++];
                splitInversions += (mid - i + 1);
            }
        }

        while (i <= mid) {
            temp[k++] = nums[i++];
        }

        while (j <= high) {
            temp[k++] = nums[j++];
        }

        for (int x = low; x <= high; x++) {
            nums[x] = temp[x];
        }

        return splitInversions;
    }
}