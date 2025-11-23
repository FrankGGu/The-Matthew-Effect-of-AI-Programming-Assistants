public class Solution {

import java.util.*;

public class Solution {
    public boolean canFormArray(int[][] arrs, int[] arr) {
        Map<Integer, int[]> map = new HashMap<>();
        for (int[] arr1 : arrs) {
            map.put(arr1[0], arr1);
        }
        int i = 0;
        while (i < arr.length) {
            if (!map.containsKey(arr[i])) {
                return false;
            }
            int[] sub = map.get(arr[i]);
            for (int j = 0; j < sub.length; j++) {
                if (i >= arr.length || arr[i] != sub[j]) {
                    return false;
                }
                i++;
            }
        }
        return true;
    }
}
}