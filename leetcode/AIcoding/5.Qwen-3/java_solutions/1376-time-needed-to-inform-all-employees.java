public class Solution {

import java.util.*;

public class Solution {
    public int numOfMinutes(int n, int headID, List<Integer> manager, List<Integer> informTime) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int i = 0; i < n; i++) {
            graph.putIfAbsent(manager.get(i), new ArrayList<>());
            graph.get(manager.get(i)).add(i);
        }

        Queue<int[]> queue = new LinkedList<>();
        queue.add(new int[]{headID, 0});

        int maxTime = 0;

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int employee = current[0];
            int time = current[1];

            maxTime = Math.max(maxTime, time);

            for (int neighbor : graph.getOrDefault(employee, new ArrayList<>())) {
                queue.add(new int[]{neighbor, time + informTime.get(employee)});
            }
        }

        return maxTime;
    }
}
}