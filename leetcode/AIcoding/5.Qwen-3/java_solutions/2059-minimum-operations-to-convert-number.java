public class Solution {

import java.util.*;

public class Solution {
    public int minimumOperationsToConvertNumber(int target, int start, int goal, int[] operations) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < operations.length; i += 2) {
            map.put(operations[i], operations[i + 1]);
        }

        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{start, 0});
        Set<Integer> visited = new HashSet<>();
        visited.add(start);

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int num = current[0];
            int steps = current[1];

            if (num == goal) {
                return steps;
            }

            if (map.containsKey(num)) {
                int nextNum = map.get(num);
                if (!visited.contains(nextNum)) {
                    visited.add(nextNum);
                    queue.offer(new int[]{nextNum, steps + 1});
                }
            }

            if (num + 1 <= target + 100 && !visited.contains(num + 1)) {
                visited.add(num + 1);
                queue.offer(new int[]{num + 1, steps + 1});
            }

            if (num - 1 >= 0 && !visited.contains(num - 1)) {
                visited.add(num - 1);
                queue.offer(new int[]{num - 1, steps + 1});
            }
        }

        return -1;
    }
}
}