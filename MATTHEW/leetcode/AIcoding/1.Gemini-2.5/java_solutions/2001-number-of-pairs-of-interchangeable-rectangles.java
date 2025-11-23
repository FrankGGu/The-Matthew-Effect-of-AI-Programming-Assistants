import java.util.HashMap;
import java.util.Map;

class Solution {
    public long interchangeableRectangles(int[][] rectangles) {
        Map<String, Integer> counts = new HashMap<>();

        for (int[] rect : rectangles) {
            int w = rect[0];
            int h = rect[1];
            int commonDivisor = gcd(w, h);
            String ratioKey = (w / commonDivisor) + "/" + (h / commonDivisor);
            counts.put(ratioKey, counts.getOrDefault(ratioKey, 0) + 1);
        }

        long totalPairs = 0;
        for (int count : counts.values()) {
            if (count > 1) {
                totalPairs += (long) count * (count - 1) / 2;
            }
        }

        return totalPairs;
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