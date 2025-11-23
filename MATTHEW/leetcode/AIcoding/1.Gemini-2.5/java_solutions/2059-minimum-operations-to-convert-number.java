import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int minimumOperations(int[] nums, int start, int target) {
        if (start == target) {
            return 0;
        }

        Queue<Integer> queue = new LinkedList<>();
        boolean[] visited = new boolean[1001]; // For numbers 0 to 1000

        queue.add(start);
        visited[start] = true;
        int operations = 0;

        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            operations++;

            for (int i = 0; i < levelSize; i++) {
                int current = queue.poll();

                for (int num : nums) {
                    // Operation 1: current + num
                    int next1 = current + num;
                    if (next1 == target) {
                        return operations;
                    }
                    if (next1 >= 0 && next1 <= 1000 && !visited[next1]) {
                        visited[next1] = true;
                        queue.add(next1);
                    }

                    // Operation 2: current - num
                    int next2 = current - num;
                    if (next2 == target) {
                        return operations;
                    }
                    if (next2 >= 0 && next2 <= 1000 && !visited[next2]) {
                        visited[next2] = true;
                        queue.add(next2);
                    }

                    // Operation 3: current ^ num (XOR)
                    int next3 = current ^ num;
                    if (next3 == target) {
                        return operations;
                    }
                    if (next3 >= 0 && next3 <= 1000 && !visited[next3]) {
                        visited[next3] = true;
                        queue.add(next3);
                    }
                }
            }
        }

        return -1; // Target is unreachable
    }
}