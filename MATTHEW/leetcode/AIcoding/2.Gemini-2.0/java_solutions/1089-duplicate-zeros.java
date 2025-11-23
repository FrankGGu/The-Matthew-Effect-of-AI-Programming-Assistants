class Solution {
    public void duplicateZeros(int[] arr) {
        int zeros = 0;
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == 0) {
                zeros++;
            }
        }

        int n = arr.length;
        int len = n + zeros;

        for (int i = n - 1, j = len - 1; i >= 0; i--, j--) {
            if (arr[i] != 0) {
                if (j < n) {
                    arr[j] = arr[i];
                }
            } else {
                if (j < n) {
                    arr[j] = 0;
                }
                j--;
                if (j < n) {
                    arr[j] = 0;
                }
            }
        }
    }
}