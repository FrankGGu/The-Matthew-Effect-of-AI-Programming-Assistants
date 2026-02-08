import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int countPairs(int[][] points, int k) {
        Map<Integer, Integer> map = new HashMap<>();
        int count = 0;

        for (int[] point : points) {
            int dist = point[0] * point[0] + point[1] * point[1];
            count += map.getOrDefault(dist - k * k, 0);
            map.put(dist, map.getOrDefault(dist, 0) + 1);
        }

        return count;
    }
}