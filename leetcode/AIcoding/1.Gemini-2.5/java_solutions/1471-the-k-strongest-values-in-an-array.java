import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int[] getStrongest(int[] arr, int k) {
        // Step 1: Sort the array to find the median
        Arrays.sort(arr);

        // Step 2: Calculate the median m
        int n = arr.length;
        int m = arr[(n - 1) / 2];

        // Step 3: Convert int[] to Integer[] for custom sorting
        Integer[] boxedArr = new Integer[n];
        for (int i = 0; i < n; i++) {
            boxedArr[i] = arr[i];
        }

        // Step 4: Sort the array using a custom comparator based on strength
        Arrays.sort(boxedArr, new Comparator<Integer>() {
            @Override
            public int compare(Integer a, Integer b) {
                int diffA = Math.abs(a - m);
                int diffB = Math.abs(b - m);

                if (diffA != diffB) {
                    // Sort by absolute difference from median in descending order
                    return Integer.compare(diffB, diffA);
                } else {
                    // If differences are equal, sort by value in descending order
                    return Integer.compare(b, a);
                }
            }
        });

        // Step 5: Take the first k elements from the sorted array
        int[] result = new int[k];
        for (int i = 0; i < k; i++) {
            result[i] = boxedArr[i];
        }

        return result;
    }
}