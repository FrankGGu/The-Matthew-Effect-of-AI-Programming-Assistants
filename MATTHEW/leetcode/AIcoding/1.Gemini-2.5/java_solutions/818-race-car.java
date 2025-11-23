import java.util.LinkedList;
import java.util.Queue;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int racecar(int target) {
        Queue<int[]> queue = new LinkedList<>(); // {position, speed, steps}
        Set<String> visited = new HashSet<>();

        queue.offer(new int[]{0, 1, 0});
        visited.add("0,1");

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int pos = current[0];
            int speed = current[1];
            int steps = current[2];

            if (pos == target) {
                return steps;
            }

            // Option 1: Accelerate ('A')
            int nextPosA = pos + speed;
            int nextSpeedA = speed * 2;
            int nextStepsA = steps + 1;

            String stateA = nextPosA + "," + nextSpeedA;

            boolean pruneA = false;
            if (nextPosA > 2 * target && nextSpeedA > 0) {
                pruneA = true;
            }
            if (nextPosA < 0 && nextSpeedA < 0) {
                pruneA = true;
            }

            if (!pruneA && !visited.contains(stateA)) {
                visited.add(stateA);
                queue.offer(new int[]{nextPosA, nextSpeedA, nextStepsA});
            }

            // Option 2: Reverse ('R')
            int nextPosR = pos;
            int nextSpeedR = (speed > 0) ? -1 : 1;
            int nextStepsR = steps + 1;

            String stateR = nextPosR + "," + nextSpeedR;

            if (!visited.contains(stateR)) {
                visited.add(stateR);
                queue.offer(new int[]{nextPosR, nextSpeedR, nextStepsR});
            }
        }

        return -1;
    }
}