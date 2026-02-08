public class Solution {

import java.util.*;

public class Solution {
    public int numBusesToDestination(int[][] routes, int source, int target) {
        if (source == target) return 0;

        Map<Integer, List<Integer>> stopToBus = new HashMap<>();
        for (int i = 0; i < routes.length; i++) {
            for (int stop : routes[i]) {
                stopToBus.putIfAbsent(stop, new ArrayList<>());
                stopToBus.get(stop).add(i);
            }
        }

        boolean[] visitedBus = new boolean[routes.length];
        Queue<Integer> queue = new LinkedList<>();
        Set<Integer> visitedStop = new HashSet<>();

        for (int bus : stopToBus.getOrDefault(source, new ArrayList<>())) {
            visitedBus[bus] = true;
            queue.offer(bus);
        }

        visitedStop.add(source);

        int steps = 1;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int bus = queue.poll();
                for (int stop : routes[bus]) {
                    if (stop == target) return steps;
                    for (int nextBus : stopToBus.getOrDefault(stop, new ArrayList<>())) {
                        if (!visitedBus[nextBus]) {
                            visitedBus[nextBus] = true;
                            queue.offer(nextBus);
                        }
                    }
                }
            }
            steps++;
        }

        return -1;
    }
}
}