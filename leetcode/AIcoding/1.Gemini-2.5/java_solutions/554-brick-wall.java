import java.util.List;
import java.util.Map;
import java.util.HashMap;

class Solution {
    public int leastBricks(List<List<Integer>> wall) {
        Map<Integer, Integer> gapFrequencies = new HashMap<>();
        int maxAlignedGaps = 0;

        for (List<Integer> row : wall) {
            int currentSum = 0;
            for (int i = 0; i < row.size() - 1; i++) {
                currentSum += row.get(i);
                gapFrequencies.put(currentSum, gapFrequencies.getOrDefault(currentSum, 0) + 1);
                maxAlignedGaps = Math.max(maxAlignedGaps, gapFrequencies.get(currentSum));
            }
        }

        return wall.size() - maxAlignedGaps;
    }
}