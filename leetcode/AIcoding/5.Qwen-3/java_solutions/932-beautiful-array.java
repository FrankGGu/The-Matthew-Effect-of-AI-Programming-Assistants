public class Solution {
    public int[] beautifulArray(int n) {
        int[] result = new int[n];
        int[] temp = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = i + 1;
        }
        return beautifulArrayHelper(result, 0, n - 1, temp);
    }

    private int[] beautifulArrayHelper(int[] arr, int left, int right, int[] temp) {
        if (left >= right) {
            return arr;
        }
        int mid = left + (right - left) / 2;
        beautifulArrayHelper(arr, left, mid, temp);
        beautifulArrayHelper(arr, mid + 1, right, temp);
        merge(arr, left, mid, right, temp);
        return arr;
    }

    private void merge(int[] arr, int left, int mid, int right, int[] temp) {
        for (int i = left; i <= right; i++) {
            temp[i] = arr[i];
        }
        int i = left;
        int j = mid + 1;
        int k = left;
        while (i <= mid && j <= right) {
            if (temp[i] * 2 < temp[j]) {
                arr[k++] = temp[i++];
            } else {
                arr[k++] = temp[j++];
            }
        }
        while (i <= mid) {
            arr[k++] = temp[i++];
        }
        while (j <= right) {
            arr[k++] = temp[j++];
        }
    }
}