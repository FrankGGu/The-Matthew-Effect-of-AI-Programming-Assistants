import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public int leastBricks(List<List<Integer>> wall) {
        Map<Integer, Integer> count = new HashMap<>();
        int maxCount = 0;
        for (List<Integer> row : wall) {
            int sum = 0;
            for (int i = 0; i < row.size() - 1; i++) {
                sum += row.get(i);
                count.put(sum, count.getOrDefault(sum, 0) + 1);
                maxCount = Math.max(maxCount, count.get(sum));
            }
        }
        return wall.size() - maxCount;
    }
}