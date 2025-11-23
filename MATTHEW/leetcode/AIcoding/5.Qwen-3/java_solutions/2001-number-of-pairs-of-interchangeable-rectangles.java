public class Solution {

import java.util.*;

public class Solution {
    public int numPairsOfInterchangeableRectangles(List<List<Integer>> rectangles) {
        Map<String, Integer> ratioCount = new HashMap<>();
        int pairs = 0;

        for (List<Integer> rect : rectangles) {
            int width = rect.get(0);
            int height = rect.get(1);
            int gcd = gcd(width, height);
            String ratio = (width / gcd) + ":" + (height / gcd);
            pairs += ratioCount.getOrDefault(ratio, 0);
            ratioCount.put(ratio, ratioCount.getOrDefault(ratio, 0) + 1);
        }

        return pairs;
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
}