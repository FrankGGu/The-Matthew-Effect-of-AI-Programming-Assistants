import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] longestObstacleCourseAtEachPosition(int[] obstacles) {
        int n = obstacles.length;
        int[] result = new int[n];
        List<Integer> tail = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            int obstacle = obstacles[i];
            int len = tail.size();

            if (len == 0 || obstacle >= tail.get(len - 1)) {
                tail.add(obstacle);
                result[i] = len + 1;
            } else {
                int left = 0;
                int right = len - 1;

                while (left < right) {
                    int mid = left + (right - left) / 2;
                    if (tail.get(mid) <= obstacle) {
                        left = mid + 1;
                    } else {
                        right = mid;
                    }
                }

                tail.set(left, obstacle);
                result[i] = left + 1;
            }
        }

        return result;
    }
}