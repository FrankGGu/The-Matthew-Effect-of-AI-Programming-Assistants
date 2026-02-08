public class Solution {

import java.util.*;

public class Solution {
    public int maxChunksToMakeSorted(int[] arr) {
        int[] sorted = Arrays.copyOf(arr, arr.length);
        Arrays.sort(sorted);
        int chunks = 0;
        int i = 0;
        while (i < arr.length) {
            int j = i;
            while (j < arr.length && arr[j] == sorted[j]) {
                j++;
            }
            if (j > i) {
                chunks++;
                i = j;
            } else {
                int maxVal = arr[i];
                int k = i;
                while (k < arr.length && arr[k] <= maxVal) {
                    maxVal = Math.max(maxVal, arr[k]);
                    k++;
                }
                chunks++;
                i = k;
            }
        }
        return chunks;
    }
}
}