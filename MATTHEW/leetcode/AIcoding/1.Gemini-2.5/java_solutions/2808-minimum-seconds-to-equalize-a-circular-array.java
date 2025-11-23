import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public int minimumSeconds(List<Integer> nums) {
        int n = nums.size();
        Map<Integer, List<Integer>> valToIndices = new HashMap<>();

        for (int i = 0; i < n; i++) {
            valToIndices.computeIfAbsent(nums.get(i), k -> new ArrayList<>()).add(i);
        }

        int minOverallMaxSeconds = Integer.MAX_VALUE;

        for (List<Integer> indices : valToIndices.values()) {
            int currentMaxSeconds = 0;
            int numOccurrences = indices.size();

            for (int i = 0; i < numOccurrences - 1; i++) {
                currentMaxSeconds = Math.max(currentMaxSeconds, (indices.get(i + 1) - indices.get(i)) / 2);
            }

            int firstIdx = indices.get(0);
            int lastIdx = indices.get(numOccurrences - 1);
            int circularGap = n - lastIdx + firstIdx;
            currentMaxSeconds = Math.max(currentMaxSeconds, circularGap / 2);

            minOverallMaxSeconds = Math.min(minOverallMaxSeconds, currentMaxSeconds);
        }

        return minOverallMaxSeconds;
    }
}