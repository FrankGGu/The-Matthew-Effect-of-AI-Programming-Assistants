import java.util.*;

class Solution {
    public int numBusesToDestination(int[][] routes, int source, int target) {
        if (source == target) {
            return 0;
        }

        int n = routes.length;
        Map<Integer, List<Integer>> stopToRoutes = new HashMap<>();
        for (int i = 0; i < n; i++) {
            for (int stop : routes[i]) {
                stopToRoutes.computeIfAbsent(stop, k -> new ArrayList<>()).add(i);
            }
        }

        Queue<Integer> queue = new LinkedList<>();
        Set<Integer> visitedStops = new HashSet<>();
        Set<Integer> visitedRoutes = new HashSet<>();

        queue.offer(source);
        visitedStops.add(source);
        int buses = 0;

        while (!queue.isEmpty()) {
            buses++;
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int stop = queue.poll();
                if (!stopToRoutes.containsKey(stop)) continue;

                for (int routeIndex : stopToRoutes.get(stop)) {
                    if (visitedRoutes.contains(routeIndex)) {
                        continue;
                    }
                    visitedRoutes.add(routeIndex);

                    for (int nextStop : routes[routeIndex]) {
                        if (nextStop == target) {
                            return buses;
                        }
                        if (!visitedStops.contains(nextStop)) {
                            queue.offer(nextStop);
                            visitedStops.add(nextStop);
                        }
                    }
                }
            }
        }

        return -1;
    }
}