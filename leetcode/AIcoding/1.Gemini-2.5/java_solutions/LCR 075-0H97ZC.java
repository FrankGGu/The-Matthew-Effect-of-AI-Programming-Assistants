import java.util.Arrays;

class Solution {
    public int[] relativeSortArray(int[] arr1, int[] arr2) {
        int[] counts = new int[1001]; // Max value is 1000
        for (int num : arr1) {
            counts[num]++;
        }

        int[] result = new int[arr1.length];
        int index = 0;

        for (int num : arr2) {
            while (counts[num] > 0) {
                result[index++] = num;
                counts[num]--;
            }
        }

        for (int i = 0; i < counts.length; i++) {
            while (counts[i] > 0) {
                result[index++] = i;
                counts[i]--;
            }
        }

        return result;
    }
}