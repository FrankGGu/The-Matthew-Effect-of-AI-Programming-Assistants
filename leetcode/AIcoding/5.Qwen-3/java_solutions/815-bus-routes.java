public class Solution {

import java.util.*;

public class Solution {
    public int numBusesToDestination(int[][] routes, int source, int target) {
        if (source == target) return 0;

        int n = routes.length;
        Map<Integer, List<Integer>> routeMap = new HashMap<>();
        for (int i = 0; i < n; i++) {
            for (int stop : routes[i]) {
                routeMap.putIfAbsent(stop, new ArrayList<>());
                routeMap.get(stop).add(i);
            }
        }

        boolean[] visitedRoutes = new boolean[n];
        Queue<Integer> queue = new LinkedList<>();
        Set<Integer> visitedStops = new HashSet<>();

        for (int route : routeMap.getOrDefault(source, new ArrayList<>())) {
            visitedRoutes[route] = true;
            queue.offer(route);
        }

        for (int stops = 1; !queue.isEmpty(); stops++) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int route = queue.poll();
                for (int stop : routes[route]) {
                    if (stop == target) return stops;
                    for (int nextRoute : routeMap.getOrDefault(stop, new ArrayList<>())) {
                        if (!visitedRoutes[nextRoute]) {
                            visitedRoutes[nextRoute] = true;
                            queue.offer(nextRoute);
                        }
                    }
                }
            }
        }

        return -1;
    }
}
}