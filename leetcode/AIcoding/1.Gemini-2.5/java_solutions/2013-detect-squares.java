import java.util.HashMap;
import java.util.Map;
import java.util.Collections;

class DetectSquares {

    Map<Integer, Map<Integer, Integer>> pointsCount;

    public DetectSquares() {
        pointsCount = new HashMap<>();
    }

    public void add(int[] point) {
        int x = point[0];
        int y = point[1];
        pointsCount.computeIfAbsent(x, k -> new HashMap<>()).merge(y, 1, Integer::sum);
    }

    public int count(int[] point) {
        int qx = point[0];
        int qy = point[1];
        int totalSquares = 0;

        Map<Integer, Integer> yCountsForQx = pointsCount.get(qx);
        if (yCountsForQx == null) {
            return 0;
        }

        for (Map.Entry<Integer, Integer> entry : yCountsForQx.entrySet()) {
            int py = entry.getKey();
            int count_qx_py = entry.getValue();

            if (py == qy) {
                continue;
            }

            int sideLength = Math.abs(qy - py);

            int x_right = qx + sideLength;
            if (x_right <= 1000) {
                int count_x_right_qy = pointsCount.getOrDefault(x_right, Collections.emptyMap()).getOrDefault(qy, 0);
                int count_x_right_py = pointsCount.getOrDefault(x_right, Collections.emptyMap()).getOrDefault(py, 0);
                totalSquares += count_qx_py * count_x_right_qy * count_x_right_py;
            }

            int x_left = qx - sideLength;
            if (x_left >= 0) {
                int count_x_left_qy = pointsCount.getOrDefault(x_left, Collections.emptyMap()).getOrDefault(qy, 0);
                int count_x_left_py = pointsCount.getOrDefault(x_left, Collections.emptyMap()).getOrDefault(py, 0);
                totalSquares += count_qx_py * count_x_left_qy * count_x_left_py;
            }
        }
        return totalSquares;
    }
}