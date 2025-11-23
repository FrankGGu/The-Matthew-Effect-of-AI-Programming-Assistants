import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int numberOfBoomerangs(int[][] points) {
        int count = 0;
        for (int[] p : points) {
            Map<Integer, Integer> map = new HashMap<>();
            for (int[] q : points) {
                if (p != q) {
                    int dist = (p[0] - q[0]) * (p[0] - q[0]) + (p[1] - q[1]) * (p[1] - q[1]);
                    map.put(dist, map.getOrDefault(dist, 0) + 1);
                }
            }
            for (int freq : map.values()) {
                count += freq * (freq - 1);
            }
        }
        return count;
    }
}