import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public int minimumSeconds(List<Integer> nums) {
        Map<Integer, List<Integer>> valToIndices = new HashMap<>();
        int n = nums.size();

        for (int i = 0; i < n; i++) {
            valToIndices.computeIfAbsent(nums.get(i), k -> new ArrayList<>()).add(i);
        }

        int minSeconds = Integer.MAX_VALUE;

        for (Map.Entry<Integer, List<Integer>> entry : valToIndices.entrySet()) {
            List<Integer> indices = entry.getValue();
            int maxGap = 0;

            maxGap = Math.max(maxGap, n - indices.get(indices.size() - 1) + indices.get(0));

            for (int i = 1; i < indices.size(); i++) {
                maxGap = Math.max(maxGap, indices.get(i) - indices.get(i - 1));
            }

            minSeconds = Math.min(minSeconds, maxGap / 2);
        }

        return minSeconds;
    }
}