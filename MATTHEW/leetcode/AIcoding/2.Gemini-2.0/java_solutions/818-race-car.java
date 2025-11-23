import java.util.*;

class Solution {
    public int racecar(int target) {
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 1, 0}); // position, speed, steps
        Set<String> visited = new HashSet<>();
        visited.add("0,1");

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int pos = curr[0];
            int speed = curr[1];
            int steps = curr[2];

            if (pos == target) {
                return steps;
            }

            // Accelerate
            int newPos1 = pos + speed;
            int newSpeed1 = speed * 2;
            if (Math.abs(newPos1 - target) < target * 2 && !visited.contains(newPos1 + "," + newSpeed1)) {
                queue.offer(new int[]{newPos1, newSpeed1, steps + 1});
                visited.add(newPos1 + "," + newSpeed1);
            }

            // Reverse
            int newSpeed2 = (speed > 0) ? -1 : 1;
            if (Math.abs(pos - target) < target * 2 && !visited.contains(pos + "," + newSpeed2)) {
                queue.offer(new int[]{pos, newSpeed2, steps + 1});
                visited.add(pos + "," + newSpeed2);
            }
        }

        return -1;
    }
}