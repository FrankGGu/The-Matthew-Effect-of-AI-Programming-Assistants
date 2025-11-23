public class Solution {

import java.util.*;

public class Solution {
    public int[] relativeSortArray(int[] arr1, int[] arr2) {
        Map<Integer, Integer> indexMap = new HashMap<>();
        for (int i = 0; i < arr2.length; i++) {
            indexMap.put(arr2[i], i);
        }

        Arrays.sort(arr1, (a, b) -> {
            int indexA = indexMap.getOrDefault(a, Integer.MAX_VALUE);
            int indexB = indexMap.getOrDefault(b, Integer.MAX_VALUE);
            if (indexA != indexB) {
                return Integer.compare(indexA, indexB);
            } else {
                return Integer.compare(a, b);
            }
        });

        return arr1;
    }
}
}