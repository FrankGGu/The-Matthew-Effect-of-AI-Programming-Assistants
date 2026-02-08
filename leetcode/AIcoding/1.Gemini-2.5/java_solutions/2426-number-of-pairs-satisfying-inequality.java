class Solution {
    long count = 0;
    int[] temp; 

    public long numberOfPairs(int[] nums1, int[] nums2, int diff) {
        int n = nums1.length;
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            arr[i] = nums1[i] - nums2[i];
        }

        temp = new int[n]; 
        mergeSortAndCount(arr, 0, n - 1, diff);
        return count;
    }

    private void mergeSortAndCount(int[] arr, int low, int high, int diff) {
        if (low >= high) {
            return;
        }

        int mid = low + (high - low) / 2;
        mergeSortAndCount(arr, low, mid, diff);
        mergeSortAndCount(arr, mid + 1, high, diff);

        int j = mid + 1;
        for (int i = low; i <= mid; i++) {
            while (j <= high && arr[i] > arr[j] + diff) {
                j++;
            }
            count += (high - j + 1);
        }

        int p1 = low;
        int p2 = mid + 1;
        int k = 0;
        while (p1 <= mid && p2 <= high) {
            if (arr[p1] <= arr[p2]) {
                temp[k++] = arr[p1++];
            } else {
                temp[k++] = arr[p2++];
            }
        }
        while (p1 <= mid) {
            temp[k++] = arr[p1++];
        }
        while (p2 <= high) {
            temp[k++] = arr[p2++];
        }

        for (int i = 0; i < k; i++) {
            arr[low + i] = temp[i];
        }
    }
}