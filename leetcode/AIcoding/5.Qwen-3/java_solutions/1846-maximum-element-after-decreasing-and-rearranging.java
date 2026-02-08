public class Solution {

import java.util.Arrays;

public class Solution {
    public int maximumElementAfterDecreasingAndRearranging(int[] arr) {
        Arrays.sort(arr);
        int n = arr.length;
        arr[n - 1] = 1;
        for (int i = n - 2; i >= 0; i--) {
            if (arr[i] > arr[i + 1] - 1) {
                arr[i] = arr[i + 1] - 1;
            }
        }
        return arr[0];
    }
}
}