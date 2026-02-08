class Solution {
    private long lower;
    private long upper;
    private int count = 0;

    public int countRangeSum(int[] nums, int lower, int upper) {
        this.lower = lower;
        this.upper = upper;

        long[] sums = new long[nums.length + 1];
        for (int i = 0; i < nums.length; i++) {
            sums[i + 1] = sums[i] + nums[i];
        }

        mergeSort(sums, 0, sums.length - 1);
        return count;
    }

    private void mergeSort(long[] sums, int start, int end) {
        if (start >= end) {
            return;
        }

        int mid = start + (end - start) / 2;
        mergeSort(sums, start, mid);
        mergeSort(sums, mid + 1, end);

        int p1 = mid + 1;
        int p2 = mid + 1;

        for (int i = start; i <= mid; i++) {
            while (p1 <= end && sums[p1] < sums[i] + lower) {
                p1++;
            }
            while (p2 <= end && sums[p2] <= sums[i] + upper) {
                p2++;
            }
            count += (p2 - p1);
        }

        long[] temp = new long[end - start + 1];
        int i = start, j = mid + 1, k = 0;
        while (i <= mid && j <= end) {
            if (sums[i] < sums[j]) {
                temp[k++] = sums[i++];
            } else {
                temp[k++] = sums[j++];
            }
        }
        while (i <= mid) {
            temp[k++] = sums[i++];
        }
        while (j <= end) {
            temp[k++] = sums[j++];
        }
        System.arraycopy(temp, 0, sums, start, temp.length);
    }
}