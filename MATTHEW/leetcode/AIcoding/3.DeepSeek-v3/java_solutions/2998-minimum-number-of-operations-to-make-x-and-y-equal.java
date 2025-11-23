import java.util.*;

class Solution {
    public int minimumOperationsToMakeEqual(int x, int y) {
        if (x == y) {
            return 0;
        }

        Queue<Integer> queue = new LinkedList<>();
        Set<Integer> visited = new HashSet<>();
        queue.offer(x);
        visited.add(x);
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int current = queue.poll();
                if (current == y) {
                    return steps;
                }

                if (current > y) {
                    if (current % 11 == 0 && !visited.contains(current / 11)) {
                        queue.offer(current / 11);
                        visited.add(current / 11);
                    }
                    if (current % 5 == 0 && !visited.contains(current / 5)) {
                        queue.offer(current / 5);
                        visited.add(current / 5);
                    }
                    if (!visited.contains(current - 1)) {
                        queue.offer(current - 1);
                        visited.add(current - 1);
                    }
                }

                if (current < y) {
                    if (!visited.contains(current + 1)) {
                        queue.offer(current + 1);
                        visited.add(current + 1);
                    }
                }
            }
            steps++;
        }

        return -1;
    }
}