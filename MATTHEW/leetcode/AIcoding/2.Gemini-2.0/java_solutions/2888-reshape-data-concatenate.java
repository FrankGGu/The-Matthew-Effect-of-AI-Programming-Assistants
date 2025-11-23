import java.util.Arrays;

class Solution {

    public int[] concatenateArrays(int[][] arrs) {
        int len = 0;
        for (int[] arr : arrs) {
            len += arr.length;
        }
        int[] result = new int[len];
        int index = 0;
        for (int[] arr : arrs) {
            for (int num : arr) {
                result[index++] = num;
            }
        }
        return result;
    }
}