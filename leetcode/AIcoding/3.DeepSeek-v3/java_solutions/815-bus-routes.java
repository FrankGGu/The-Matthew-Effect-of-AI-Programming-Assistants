class Solution {
    public int numBusesToDestination(int[][] routes, int source, int target) {
        if (source == target) return 0;

        Map<Integer, List<Integer>> stopToBuses = new HashMap<>();
        for (int i = 0; i < routes.length; i++) {
            for (int stop : routes[i]) {
                stopToBuses.putIfAbsent(stop, new ArrayList<>());
                stopToBuses.get(stop).add(i);
            }
        }

        Queue<Integer> queue = new LinkedList<>();
        Set<Integer> visitedBuses = new HashSet<>();
        Set<Integer> visitedStops = new HashSet<>();

        queue.offer(source);
        visitedStops.add(source);
        int level = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int currentStop = queue.poll();
                for (int bus : stopToBuses.getOrDefault(currentStop, new ArrayList<>())) {
                    if (visitedBuses.contains(bus)) continue;
                    visitedBuses.add(bus);
                    for (int stop : routes[bus]) {
                        if (stop == target) return level + 1;
                        if (!visitedStops.contains(stop)) {
                            visitedStops.add(stop);
                            queue.offer(stop);
                        }
                    }
                }
            }
            level++;
        }

        return -1;
    }
}