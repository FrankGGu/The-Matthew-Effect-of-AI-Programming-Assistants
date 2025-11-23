public class Solution {
    public int longestMountain(int[] arr) {
        int n = arr.length;
        int max = 0;
        int up = 0;
        int down = 0;

        for (int i = 1; i < n; i++) {
            if (down > 0 && arr[i] > arr[i - 1] || arr[i] == arr[i - 1]) {
                up = 0;
                down = 0;
            }
            if (arr[i] > arr[i - 1]) {
                up++;
            } else if (arr[i] < arr[i - 1]) {
                down++;
            }
            if (up > 0 && down > 0) {
                max = Math.max(max, up + down + 1);
            }
        }
        return max;
    }
}