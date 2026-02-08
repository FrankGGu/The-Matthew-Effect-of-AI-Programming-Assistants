class Solution {
    public int longestMountain(int[] arr) {
        int n = arr.length;
        int maxLen = 0;
        int i = 1;

        while (i < n) {
            int up = 0, down = 0;

            while (i < n && arr[i] > arr[i - 1]) {
                up++;
                i++;
            }

            while (i < n && arr[i] < arr[i - 1]) {
                down++;
                i++;
            }

            if (up > 0 && down > 0) {
                maxLen = Math.max(maxLen, up + down + 1);
            }

            while (i < n && arr[i] == arr[i - 1]) {
                i++;
            }
        }

        return maxLen;
    }
}