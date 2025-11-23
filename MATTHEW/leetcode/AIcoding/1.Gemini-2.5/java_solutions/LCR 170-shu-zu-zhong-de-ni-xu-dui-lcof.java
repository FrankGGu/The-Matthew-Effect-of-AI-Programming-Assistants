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
        count += countPairs(nums, low, mid, high);
        merge(nums, low, mid, high);
        return count;
    }

    private int countPairs(int[] nums, int low, int mid, int high) {
        int count = 0;
        int j = mid + 1; 
        for (int i = low; i <= mid; i++) { 
            while (j <= high && (long) nums[i] > 2 * (long) nums[j]) {
                j++;
            }
            count += (j - (mid + 1)); 
        }
        return count;
    }

    private void merge(int[] nums, int low, int mid, int high) {
        int[] temp = new int[high - low + 1];
        int i = low;
        int j = mid + 1;
        int k = 0;

        while (i <= mid && j <= high) {
            if (nums[i] <= nums[j]) {
                temp[k++] = nums[i++];
            } else {
                temp[k++] = nums[j++];
            }
        }

        while (i <= mid) {
            temp[k++] = nums[i++];
        }

        while (j <= high) {
            temp[k++] = nums[j++];
        }

        for (int l = 0; l < temp.length; l++) {
            nums[low + l] = temp[l];
        }
    }
}