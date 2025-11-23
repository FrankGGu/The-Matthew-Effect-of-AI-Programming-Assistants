class Solution {
    public int reversePairs(int[] nums) {
        if (nums == null || nums.length < 2) {
            return 0;
        }
        return mergeSortAndCount(nums, 0, nums.length - 1);
    }

    private int mergeSortAndCount(int[] nums, int low, int high) {
        if (low >= high) {
            return 0;
        }

        int mid = low + (high - low) / 2;
        int count = mergeSortAndCount(nums, low, mid);
        count += mergeSortAndCount(nums, mid + 1, high);
        count += countReversePairs(nums, low, mid, high);
        merge(nums, low, mid, high);
        return count;
    }

    private int countReversePairs(int[] nums, int low, int mid, int high) {
        int pairs = 0;
        int j = mid + 1;
        for (int i = low; i <= mid; i++) {
            while (j <= high && (long) nums[i] > 2 * (long) nums[j]) {
                j++;
            }
            pairs += (j - (mid + 1));
        }
        return pairs;
    }

    private void merge(int[] nums, int low, int mid, int high) {
        int[] temp = new int[high - low + 1];
        int p1 = low;
        int p2 = mid + 1;
        int k = 0;

        while (p1 <= mid && p2 <= high) {
            if (nums[p1] <= nums[p2]) {
                temp[k++] = nums[p1++];
            } else {
                temp[k++] = nums[p2++];
            }
        }

        while (p1 <= mid) {
            temp[k++] = nums[p1++];
        }

        while (p2 <= high) {
            temp[k++] = nums[p2++];
        }

        for (int i = 0; i < temp.length; i++) {
            nums[low + i] = temp[i];
        }
    }
}