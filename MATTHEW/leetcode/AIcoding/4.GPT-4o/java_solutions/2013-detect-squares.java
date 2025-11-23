import java.util.HashMap;
import java.util.Map;

class DetectSquares {
    private Map<String, Integer> pointCount;

    public DetectSquares() {
        pointCount = new HashMap<>();
    }

    public void add(int[] point) {
        String key = point[0] + "," + point[1];
        pointCount.put(key, pointCount.getOrDefault(key, 0) + 1);
    }

    public int count(int[] point) {
        int x = point[0], y = point[1], count = 0;

        for (String key : pointCount.keySet()) {
            String[] parts = key.split(",");
            int x2 = Integer.parseInt(parts[0]);
            int y2 = Integer.parseInt(parts[1]);

            if (Math.abs(x2 - x) == Math.abs(y2 - y) && x2 != x && y2 != y) {
                count += pointCount.get(key) * pointCount.getOrDefault(x + "," + y2, 0) * pointCount.getOrDefault(x2 + "," + y, 0);
            }
        }

        return count;
    }
}