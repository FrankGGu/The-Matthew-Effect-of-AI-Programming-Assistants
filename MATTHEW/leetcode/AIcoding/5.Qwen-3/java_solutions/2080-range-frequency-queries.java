public class Solution {

import java.util.*;

public class RangeFrequencyQueries {
    private Map<Integer, List<Integer>> indexMap;

    public RangeFrequencyQueries(int[] arr) {
        indexMap = new HashMap<>();
        for (int i = 0; i < arr.length; i++) {
            indexMap.computeIfAbsent(arr[i], k -> new ArrayList<>()).add(i);
        }
    }

    public int query(int left, int right, int value) {
        List<Integer> indices = indexMap.getOrDefault(value, Collections.emptyList());
        int low = 0, high = indices.size() - 1;
        int leftPos = -1;
        while (low <= high) {
            int mid = (low + high) / 2;
            if (indices.get(mid) >= left) {
                leftPos = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        low = 0;
        high = indices.size() - 1;
        int rightPos = -1;
        while (low <= high) {
            int mid = (low + high) / 2;
            if (indices.get(mid) <= right) {
                rightPos = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        if (leftPos == -1 || rightPos == -1) {
            return 0;
        }
        return rightPos - leftPos + 1;
    }
}
}