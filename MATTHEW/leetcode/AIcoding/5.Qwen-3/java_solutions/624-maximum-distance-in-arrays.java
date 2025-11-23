public class Solution {

import java.util.*;

public class Solution {
    public int maximumDistanceInArrays(List<List<Integer>> arrays) {
        int minVal = Integer.MAX_VALUE;
        int maxVal = Integer.MIN_VALUE;
        int minIndex = -1;
        int maxIndex = -1;

        for (int i = 0; i < arrays.size(); i++) {
            List<Integer> arr = arrays.get(i);
            if (!arr.isEmpty()) {
                if (arr.get(0) < minVal) {
                    minVal = arr.get(0);
                    minIndex = i;
                }
                if (arr.get(arr.size() - 1) > maxVal) {
                    maxVal = arr.get(arr.size() - 1);
                    maxIndex = i;
                }
            }
        }

        if (minIndex != maxIndex) {
            return maxVal - minVal;
        } else {
            int maxDiff = 0;
            for (int i = 0; i < arrays.size(); i++) {
                List<Integer> arr = arrays.get(i);
                if (!arr.isEmpty()) {
                    if (i != minIndex) {
                        maxDiff = Math.max(maxDiff, arr.get(arr.size() - 1) - minVal);
                    }
                    if (i != maxIndex) {
                        maxDiff = Math.max(maxDiff, maxVal - arr.get(0));
                    }
                }
            }
            return maxDiff;
        }
    }
}
}