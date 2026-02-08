import java.util.*;

class Solution {
    public int minimumJumps(int[] forbidden, int a, int b, int x) {
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 0});
        Set<String> visited = new HashSet<>();
        visited.add("0 0");

        Set<Integer> forbiddenSet = new HashSet<>();
        for (int f : forbidden) {
            forbiddenSet.add(f);
        }

        int steps = 0;
        int maxReach = 2000 + 2 * b;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] curr = queue.poll();
                int pos = curr[0];
                int back = curr[1];

                if (pos == x) {
                    return steps;
                }

                int forward = pos + a;
                if (forward <= maxReach && !forbiddenSet.contains(forward) && !visited.contains(forward + " 0")) {
                    queue.offer(new int[]{forward, 0});
                    visited.add(forward + " 0");
                }

                int backward = pos - b;
                if (back == 0 && backward >= 0 && !forbiddenSet.contains(backward) && !visited.contains(backward + " 1")) {
                    queue.offer(new int[]{backward, 1});
                    visited.add(backward + " 1");
                }
            }
            steps++;
        }

        return -1;
    }
}