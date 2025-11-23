import java.util.HashMap;
import java.util.Map;

class Solution {
    public long interchangeableRectangles(int[][] rectangles) {
        Map<String, Long> ratioCount = new HashMap<>();
        long res = 0;

        for (int[] rect : rectangles) {
            int width = rect[0];
            int height = rect[1];
            int gcd = gcd(width, height);
            String key = (width / gcd) + "/" + (height / gcd);
            res += ratioCount.getOrDefault(key, 0L);
            ratioCount.put(key, ratioCount.getOrDefault(key, 0L) + 1);
        }

        return res;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}