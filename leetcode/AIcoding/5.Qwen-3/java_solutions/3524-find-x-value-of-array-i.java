public class Solution {

import java.util.*;

public class Solution {
    public int[] findXValues(int[] array, int x) {
        int n = array.length;
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = array[i] + x;
        }
        return result;
    }
}
}