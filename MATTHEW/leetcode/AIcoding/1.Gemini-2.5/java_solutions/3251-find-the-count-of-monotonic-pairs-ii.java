class Solution {
    private long count;
    private int[] temp;

    public long countMonotonicPairs(int[] nums) {
        count = 0;
        int n = nums.length;
        if (n <= 1) {
            return 0;
        }
        temp = new int[n];
        mergeSortAndCount(nums, 0, n - 1);
        return count;
    }

    private void mergeSortAndCount(int[] nums, int low, int high) {
        if (low >= high) {
            return;
        }
        int mid = low + (high - low) / 2;
        mergeSortAndCount(nums, low, mid);
        mergeSortAndCount(nums, mid + 1, high);
        merge(nums, low, mid, high);
    }

    private void merge(int[] nums, int low, int mid, int high) {
        int p1 = low;
        int p2 = mid + 1;
        while (p1 <= mid && p2 <= high) {
            if (nums[p1] <= nums[p2]) {
                count += (high - p2 + 1);
                p1++;
            } else {
                p2++;
            }
        }

        int i = low;
        int j = mid + 1;
        int k = low;

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

        for (int x = low; x <= high; x++) {
            nums[x] = temp[x];
        }
    }
}