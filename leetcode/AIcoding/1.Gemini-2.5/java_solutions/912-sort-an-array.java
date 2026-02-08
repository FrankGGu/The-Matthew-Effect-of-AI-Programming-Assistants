class Solution {
    public int[] sortArray(int[] nums) {
        if (nums == null || nums.length <= 1) {
            return nums;
        }
        int[] temp = new int[nums.length];
        mergeSort(nums, 0, nums.length - 1, temp);
        return nums;
    }

    private void mergeSort(int[] nums, int left, int right, int[] temp) {
        if (left >= right) {
            return;
        }
        int mid = left + (right - left) / 2;
        mergeSort(nums, left, mid, temp);
        mergeSort(nums, mid + 1, right, temp);
        merge(nums, left, mid, right, temp);
    }

    private void merge(int[] nums, int left, int mid, int right, int[] temp) {
        for (int i = left; i <= right; i++) {
            temp[i] = nums[i];
        }

        int p1 = left;
        int p2 = mid + 1;
        int k = left;

        while (p1 <= mid && p2 <= right) {
            if (temp[p1] <= temp[p2]) {
                nums[k++] = temp[p1++];
            } else {
                nums[k++] = temp[p2++];
            }
        }

        while (p1 <= mid) {
            nums[k++] = temp[p1++];
        }

        while (p2 <= right) {
            nums[k++] = temp[p2++];
        }
    }
}