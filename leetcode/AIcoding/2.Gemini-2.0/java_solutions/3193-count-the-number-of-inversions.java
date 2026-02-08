class Solution {
    private long mergeAndCount(int[] arr, int l, int m, int r) {
        int[] left = new int[m - l + 1];
        int[] right = new int[r - m];

        for (int i = 0; i < left.length; i++)
            left[i] = arr[l + i];
        for (int i = 0; i < right.length; i++)
            right[i] = arr[m + 1 + i];

        int i = 0, j = 0, k = l;
        long inversions = 0;

        while (i < left.length && j < right.length) {
            if (left[i] <= right[j]) {
                arr[k++] = left[i++];
            } else {
                arr[k++] = right[j++];
                inversions += (left.length - i);
            }
        }

        while (i < left.length) {
            arr[k++] = left[i++];
        }

        while (j < right.length) {
            arr[k++] = right[j++];
        }

        return inversions;
    }

    private long mergeSortAndCount(int[] arr, int l, int r) {
        long inversions = 0;
        if (l < r) {
            int m = (l + r) / 2;

            inversions += mergeSortAndCount(arr, l, m);
            inversions += mergeSortAndCount(arr, m + 1, r);

            inversions += mergeAndCount(arr, l, m, r);
        }
        return inversions;
    }

    public long countInversions(int[] arr) {
        return mergeSortAndCount(arr, 0, arr.length - 1);
    }
}