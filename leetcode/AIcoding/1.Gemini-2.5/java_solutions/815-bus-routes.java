import java.util.*;

class Solution {
    public int numBusesToDestination(int[][] routes, int source, int target) {
        if (source == target) {
            return 0;
        }

        Map<Integer, List<Integer>> stopToRoutes = new HashMap<>();
        for (int i = 0; i < routes.length; i++) {
            for (int stop : routes[i]) {
                stopToRoutes.computeIfAbsent(stop, k -> new ArrayList<>()).add(i);
            }
        }

        Queue<Integer> q = new LinkedList<>();
        Set<Integer> visitedRoutes = new HashSet<>();

        if (!stopToRoutes.containsKey(source)) {
            return -1; 
        }

        for (int routeId : stopToRoutes.get(source)) {
            q.offer(routeId);
            visitedRoutes.add(routeId);
        }

        int busesTaken = 0;

        while (!q.isEmpty()) {
            busesTaken++;
            int levelSize = q.size();

            for (int i = 0; i < levelSize; i++) {
                int currentRouteId = q.poll();

                for (int stop : routes[currentRouteId]) {
                    if (stop == target) {
                        return busesTaken;
                    }

                    if (stopToRoutes.containsKey(stop)) {
                        for (int nextRouteId : stopToRoutes.get(stop)) {
                            if (!visitedRoutes.contains(nextRouteId)) {
                                visitedRoutes.add(nextRouteId);
                                q.offer(nextRouteId);
                            }
                        }
                    }
                }
            }
        }

        return -1;
    }
}