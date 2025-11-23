import java.util.*;

class Solution {
    public int minimumCost(int[] start, int[] target, int[][] specialRoads) {
        // Step 1: Collect all unique points involved in the path.
        // These include the start, target, and all start/end points of special roads.
        Set<List<Integer>> uniquePointsSet = new HashSet<>();
        uniquePointsSet.add(Arrays.asList(start[0], start[1]));
        uniquePointsSet.add(Arrays.asList(target[0], target[1]));

        for (int[] road : specialRoads) {
            uniquePointsSet.add(Arrays.asList(road[0], road[1]));
            uniquePointsSet.add(Arrays.asList(road[2], road[3]));
        }

        // Step 2: Map each unique point to an integer index for graph representation.
        List<List<Integer>> pointsList = new ArrayList<>(uniquePointsSet);
        Map<List<Integer>, Integer> pointToIndexMap = new HashMap<>();
        for (int i = 0; i < pointsList.size(); i++) {
            pointToIndexMap.put(pointsList.get(i), i);
        }

        // Step 3: Initialize distance array for Dijkstra's algorithm.
        // Use long to prevent potential overflow, as total costs can be large.
        int numNodes = pointsList.size();
        long[] dist = new long[numNodes];
        Arrays.fill(dist, Long.MAX_VALUE);

        int startIndex = pointToIndexMap.get(Arrays.asList(start[0], start[1]));
        int targetIndex = pointToIndexMap.get(Arrays.asList(target[0], target[1]));
        dist[startIndex] = 0;

        // Step 4: Use a PriorityQueue for Dijkstra's algorithm.
        // Stores elements as [cost, node_index].
        PriorityQueue<long[]> pq = new PriorityQueue<>((a, b) -> Long.compare(a[0], b[0]));
        pq.offer(new long[]{0, startIndex});

        // Step 5: Main Dijkstra loop
        while (!pq.isEmpty()) {
            long[] current = pq.poll();
            long currentCost = current[0];
            int uIndex = (int) current[1];

            // If we found a shorter path to uIndex already, skip this entry.
            if (currentCost > dist[uIndex]) {
                continue;
            }

            List<Integer> uPoint = pointsList.get(uIndex);
            int ux = uPoint.get(0);
            int uy = uPoint.get(1);

            // Consider all other points as neighbors via Manhattan distance (normal travel).
            for (int vIndex = 0; vIndex < numNodes; vIndex++) {
                if (uIndex == vIndex) continue; // Don't calculate distance to itself

                List<Integer> vPoint = pointsList.get(vIndex);
                int vx = vPoint.get(0);
                int vy = vPoint.get(1);

                long manhattanCost = Math.abs(ux - vx) + Math.abs(uy - vy);

                // Update distance if a shorter path is found.
                // Ensure dist[uIndex] is not MAX_VALUE to prevent overflow.
                if (dist[uIndex] != Long.MAX_VALUE && dist[uIndex] + manhattanCost < dist[vIndex]) {
                    dist[vIndex] = dist[uIndex] + manhattanCost;
                    pq.offer(new long[]{dist[vIndex], vIndex});
                }
            }

            // Consider special roads starting from uPoint.
            for (int[] road : specialRoads) {
                int sx = road[0];
                int sy = road[1];
                int ex = road[2];
                int ey = road[3];
                int roadCost = road[4];

                // If this special road starts at the current point uPoint.
                if (ux == sx && uy == sy) {
                    List<Integer> endPoint = Arrays.asList(ex, ey);
                    // The end point of a special road must be in our map.
                    int vIndex = pointToIndexMap.get(endPoint);

                    // Update distance if a shorter path is found using this special road.
                    // Ensure dist[uIndex] is not MAX_VALUE to prevent overflow.
                    if (dist[uIndex] != Long.MAX_VALUE && dist[uIndex] + roadCost < dist[vIndex]) {
                        dist[vIndex] = dist[uIndex] + roadCost;
                        pq.offer(new long[]{dist[vIndex], vIndex});
                    }
                }
            }
        }

        // Step 6: Return the minimum cost to reach the target point.
        // The problem expects an int return type, assuming the final answer fits.
        return (int) dist[targetIndex];
    }
}