import java.util.*;

public class Solution {
    public int numBusesToDestination(int[][] routes, int S, int T) {
        if (S == T) return 0;

        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int i = 0; i < routes.length; i++) {
            for (int stop : routes[i]) {
                graph.putIfAbsent(stop, new ArrayList<>());
                graph.get(stop).add(i);
            }
        }

        Queue<Integer> queue = new LinkedList<>();
        Set<Integer> visitedStops = new HashSet<>();
        Set<Integer> visitedRoutes = new HashSet<>();
        queue.offer(S);
        visitedStops.add(S);

        int buses = 0;

        while (!queue.isEmpty()) {
            buses++;
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int stop = queue.poll();
                for (int route : graph.getOrDefault(stop, new ArrayList<>())) {
                    if (visitedRoutes.contains(route)) continue;
                    visitedRoutes.add(route);
                    for (int nextStop : routes[route]) {
                        if (nextStop == T) return buses;
                        if (!visitedStops.contains(nextStop)) {
                            visitedStops.add(nextStop);
                            queue.offer(nextStop);
                        }
                    }
                }
            }
        }

        return -1;
    }
}