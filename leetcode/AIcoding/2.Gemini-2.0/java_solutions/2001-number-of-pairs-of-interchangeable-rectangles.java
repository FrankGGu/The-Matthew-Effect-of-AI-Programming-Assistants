import java.util.HashMap;
import java.util.Map;

class Solution {
    public long interchangeableRectangles(int[][] rectangles) {
        Map<Double, Long> ratioCount = new HashMap<>();
        long count = 0;
        for (int[] rectangle : rectangles) {
            double ratio = (double) rectangle[0] / rectangle[1];
            if (ratioCount.containsKey(ratio)) {
                count += ratioCount.get(ratio);
                ratioCount.put(ratio, ratioCount.get(ratio) + 1);
            } else {
                ratioCount.put(ratio, 1L);
            }
        }
        return count;
    }
}