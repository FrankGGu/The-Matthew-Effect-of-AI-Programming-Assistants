import java.util.*;

class Solution {
    public int numBusesToDestination(int[][] routes, int source, int target) {
        if (source == target) {
            return 0;
        }

        // Map each stop to a list of bus routes that pass through it.
        Map<Integer, List<Integer>> stopToRoutes = new HashMap<>();
        for (int i = 0; i < routes.length; i++) {
            for (int stop : routes[i]) {
                stopToRoutes.computeIfAbsent(stop, k -> new ArrayList<>()).add(i);
            }
        }

        // Queue for BFS, storing route indices.
        Queue<Integer> q = new LinkedList<>();
        // Set to keep track of visited routes to avoid cycles and redundant processing.
        boolean[] visitedRoutes = new boolean[routes.length];

        // Initialize BFS: Find all routes that start at the source.
        List<Integer> initialRoutes = stopToRoutes.get(source);
        if (initialRoutes == null) {
            return -1; // Source stop is not on any route.
        }

        for (int routeIdx : initialRoutes) {
            q.offer(routeIdx);
            visitedRoutes[routeIdx] = true;
        }

        int busesTaken = 0;

        // Perform BFS
        while (!q.isEmpty()) {
            busesTaken++;
            int levelSize = q.size();

            for (int i = 0; i < levelSize; i++) {
                int currentRouteIdx = q.poll();

                for (int stop : routes[currentRouteIdx]) {
                    if (stop == target) {
                        return busesTaken; // Target reached.
                    }

                    // For each stop on the current route, find all other routes
                    // that pass through this stop.
                    // Optimization: Once a stop has been processed (i.e., all its connecting routes
                    // have been added to the queue), we don't need to process it again.
                    // We achieve this by setting its entry in stopToRoutes to null or clearing the list.
                    List<Integer> connectingRoutes = stopToRoutes.get(stop);
                    if (connectingRoutes != null) {
                        for (int nextRouteIdx : connectingRoutes) {
                            if (!visitedRoutes[nextRouteIdx]) {
                                visitedRoutes[nextRouteIdx] = true;
                                q.offer(nextRouteIdx);
                            }
                        }
                        // Mark this stop as processed to avoid re-adding its connecting routes.
                        stopToRoutes.put(stop, null); 
                    }
                }
            }
        }

        return -1; // Target not reachable.
    }
}