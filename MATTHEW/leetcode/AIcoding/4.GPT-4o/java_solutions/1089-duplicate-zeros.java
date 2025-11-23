class Solution {
    public void duplicateZeros(int[] arr) {
        int n = arr.length;
        int countZeros = 0;

        for (int i = 0; i < n; i++) {
            if (arr[i] == 0) {
                countZeros++;
            }
        }

        for (int i = n - 1, j = n + countZeros - 1; i >= 0; i--) {
            if (j < n) {
                arr[j] = arr[i];
            }
            if (arr[i] == 0) {
                j--;
                if (j < n) {
                    arr[j] = 0;
                }
            }
            j--;
        }
    }
}