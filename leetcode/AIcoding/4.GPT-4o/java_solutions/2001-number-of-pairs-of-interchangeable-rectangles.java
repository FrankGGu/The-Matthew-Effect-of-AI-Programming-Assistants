import java.util.HashMap;

public class Solution {
    public long interchangeableRectangles(int[][] rectangles) {
        HashMap<Double, Long> map = new HashMap<>();
        long count = 0;

        for (int[] rectangle : rectangles) {
            double ratio = (double) rectangle[0] / rectangle[1];
            count += map.getOrDefault(ratio, 0L);
            map.put(ratio, map.getOrDefault(ratio, 0L) + 1);
        }

        return count;
    }
}