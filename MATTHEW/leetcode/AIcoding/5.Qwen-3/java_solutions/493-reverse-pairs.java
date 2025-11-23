public class Solution {
    public int reversePairs(int[] nums) {
        return mergeSort(nums, 0, nums.length - 1);
    }

    private int mergeSort(int[] nums, int left, int right) {
        if (left >= right) return 0;
        int mid = left + (right - left) / 2;
        int count = mergeSort(nums, left, mid) + mergeSort(nums, mid + 1, right);
        count += merge(nums, left, mid, right);
        return count;
    }

    private int merge(int[] nums, int left, int mid, int right) {
        int i = left, j = mid + 1, k = left;
        int count = 0;
        while (i <= mid && j <= right) {
            if (nums[i] <= nums[j]) {
                nums[k++] = nums[i++];
            } else {
                nums[k++] = nums[j++];
                count += mid - i + 1;
            }
        }
        while (i <= mid) {
            nums[k++] = nums[i++];
        }
        while (j <= right) {
            nums[k++] = nums[j++];
        }
        return count;
    }
}