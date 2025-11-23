public class Solution {

import java.util.*;

public class Solution {
    public int raceCar(int target) {
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 1});
        Set<String> visited = new HashSet<>();
        visited.add("0-1");

        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] state = queue.poll();
                int pos = state[0];
                int speed = state[1];

                if (pos == target) {
                    return steps;
                }

                // Accelerate
                int newPos = pos + speed;
                int newSpeed = speed * 2;
                String key = newPos + "-" + newSpeed;
                if (!visited.contains(key) && newPos >= 0 && newPos <= 2 * target) {
                    visited.add(key);
                    queue.offer(new int[]{newPos, newSpeed});
                }

                // Reverse
                newPos = pos;
                newSpeed = -1;
                if (speed > 0) {
                    newSpeed = -1;
                } else {
                    newSpeed = 1;
                }
                key = newPos + "-" + newSpeed;
                if (!visited.contains(key) && newPos >= 0 && newPos <= 2 * target) {
                    visited.add(key);
                    queue.offer(new int[]{newPos, newSpeed});
                }
            }
            steps++;
        }

        return -1;
    }
}
}