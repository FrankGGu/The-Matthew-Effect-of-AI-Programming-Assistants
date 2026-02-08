class Solution {
    public long numberOfPairs(int[] nums1, int[] nums2, int diff) {
        int n = nums1.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = nums1[i] - nums2[i];
        }
        int[] temp = new int[n];
        long res = 0;
        mergeSort(nums, 0, n - 1, temp, diff, res);
        return res;
    }

    private void mergeSort(int[] nums, int left, int right, int[] temp, int diff, long res) {
        if (left >= right) {
            return;
        }
        int mid = left + (right - left) / 2;
        mergeSort(nums, left, mid, temp, diff, res);
        mergeSort(nums, mid + 1, right, temp, diff, res);
        merge(nums, left, mid, right, temp, diff, res);
    }

    private void merge(int[] nums, int left, int mid, int right, int[] temp, int diff, long res) {
        int i = left;
        int j = mid + 1;
        int k = left;
        while (i <= mid && j <= right) {
            if (nums[i] <= nums[j] + diff) {
                res += right - j + 1;
                i++;
            } else {
                j++;
            }
        }
        i = left;
        j = mid + 1;
        while (i <= mid && j <= right) {
            if (nums[i] <= nums[j]) {
                temp[k++] = nums[i++];
            } else {
                temp[k++] = nums[j++];
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
    }
}