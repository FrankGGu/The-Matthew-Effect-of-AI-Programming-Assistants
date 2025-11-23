import java.util.*;

class Solution {
    public int findCheapestPrice(int n, int[][] flights, int src, int dst, int k) {
        // Adjacency list: city -> List<[destination, price]>
        List<int[]>[] adj = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }

        for (int[] flight : flights) {
            adj[flight[0]].add(new int[]{flight[1], flight[2]});
        }

        // dist[city][segments] stores the minimum cost to reach 'city' using 'segments' flights.
        // 'segments' represents the number of flights taken.
        // 'K stops' means at most K intermediate stops, which translates to at most K+1 segments.
        // So, 'segments' can range from 0 (for the source city itself) to K+1.
        int[][] dist = new int[n][k + 2]; // k+2 for indices 0 to K+1
        for (int[] row : dist) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }

        // Priority Queue stores {cost, city, segments_taken}
        // It sorts by cost to ensure Dijkstra's property.
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        // Initial state: cost 0, start city, 0 segments taken.
        dist[src][0] = 0;
        pq.offer(new int[]{0, src, 0});

        int minCost = Integer.MAX_VALUE;

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int currentCost = current[0];
            int currentCity = current[1];
            int segmentsTaken = current[2];

            // If we've already found a cheaper path to this state (city, segmentsTaken), skip.
            // This is crucial for Dijkstra's correctness.
            if (currentCost > dist[currentCity][segmentsTaken]) {
                continue;
            }

            // If the current city is the destination, update the overall minimum cost.
            // Since the PQ extracts states in increasing order of cost, this will correctly
            // find the cheapest path to 'dst' regardless of the number of segments,
            // as long as the segments are within the K+1 limit.
            if (currentCity == dst) {
                minCost = Math.min(minCost, currentCost);
            }

            // If we have already taken K+1 segments, we cannot take any more flights
            // as this would exceed the 'K stops' limit.
            if (segmentsTaken >= k + 1) {
                continue;
            }

            // Explore neighbors
            for (int[] neighbor : adj[currentCity]) {
                int nextCity = neighbor[0];
                int flightPrice = neighbor[1];
                int nextSegments = segmentsTaken + 1;

                // If the path to nextCity through currentCity is cheaper than any previously
                // found path to nextCity with 'nextSegments' flights, update and add to PQ.
                if (currentCost + flightPrice < dist[nextCity][nextSegments]) {
                    dist[nextCity][nextSegments] = currentCost + flightPrice;
                    pq.offer(new int[]{currentCost + flightPrice, nextCity, nextSegments});
                }
            }
        }

        // If minCost remains Integer.MAX_VALUE, it means no path was found within K stops.
        return minCost == Integer.MAX_VALUE ? -1 : minCost;
    }
}