public class Solution {

import java.util.Arrays;

public class Solution {
    public int maximizeGreatness(int[] array) {
        int n = array.length;
        int[] sorted = Arrays.copyOf(array, n);
        Arrays.sort(sorted);
        int i = 0, j = 0;
        while (i < n && j < n) {
            if (sorted[j] > array[i]) {
                i++;
            }
            j++;
        }
        return i;
    }
}
}