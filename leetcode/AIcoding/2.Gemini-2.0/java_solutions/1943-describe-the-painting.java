import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

class Solution {
    public List<List<Long>> splitPainting(int[][] segments) {
        TreeMap<Integer, Long> timeline = new TreeMap<>();
        for (int[] segment : segments) {
            timeline.put(segment[0], timeline.getOrDefault(segment[0], 0L) + segment[2]);
            timeline.put(segment[1], timeline.getOrDefault(segment[1], 0L) - segment[2]);
        }

        List<List<Long>> result = new ArrayList<>();
        int start = -1;
        long color = 0;
        for (Map.Entry<Integer, Long> entry : timeline.entrySet()) {
            int point = entry.getKey();
            if (color > 0) {
                result.add(Arrays.asList((long) start, (long) point, color));
            }
            start = point;
            color += entry.getValue();
        }

        return result;
    }
}