import java.util.Arrays;

class Solution {
    public int[] getStrongest(int[] arr, int k) {
        Arrays.sort(arr);
        int n = arr.length;
        int m = arr[(n - 1) / 2];

        int[] result = new int[k];
        int left = 0, right = n - 1;
        for (int i = 0; i < k; i++) {
            if (Math.abs(arr[right] - m) >= Math.abs(arr[left] - m)) {
                result[i] = arr[right];
                right--;
            } else {
                result[i] = arr[left];
                left++;
            }
        }
        return result;
    }
}