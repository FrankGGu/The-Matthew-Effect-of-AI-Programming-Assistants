import java.util.*;

class Solution {
    public List<Integer> findServersThatHandledMostRequests(int k, int[] arrival, int[] load) {
        // Stores server IDs that are currently available.
        // Using TreeSet for efficient finding of ceiling element and first element.
        TreeSet<Integer> availableServers = new TreeSet<>();
        for (int i = 0; i < k; i++) {
            availableServers.add(i);
        }

        // Stores servers that are currently busy.
        // PriorityQueue stores int[] {finishTime, serverId}, ordered by finishTime.
        PriorityQueue<int[]> busyServers = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        // Stores the count of requests handled by each server.
        int[] requestCounts = new int[k];

        for (int i = 0; i < arrival.length; i++) {
            int currentArrival = arrival[i];
            int currentLoad = load[i];

            // Step 1: Free up servers whose tasks have finished by currentArrival.
            while (!busyServers.isEmpty() && busyServers.peek()[0] <= currentArrival) {
                int[] serverInfo = busyServers.poll();
                int serverId = serverInfo[1];
                availableServers.add(serverId);
            }

            // Step 2: Try to find an available server.
            // Preferred server index is i % k.
            int preferredServerIdx = i % k;
            Integer assignedServer = null;

            if (availableServers.isEmpty()) {
                // No server available, request is dropped.
                continue;
            }

            // Try to find a server with index >= preferredServerIdx
            Integer ceilingServer = availableServers.ceiling(preferredServerIdx);
            if (ceilingServer != null) {
                assignedServer = ceilingServer;
            } else {
                // Wrap around: find the smallest index server
                assignedServer = availableServers.first();
            }

            // Step 3: Assign the request to the chosen server.
            if (assignedServer != null) {
                availableServers.remove(assignedServer);
                requestCounts[assignedServer]++;
                busyServers.offer(new int[]{currentArrival + currentLoad, assignedServer});
            }
        }

        // Step 4: Find servers that handled the most requests.
        int maxRequests = 0;
        for (int count : requestCounts) {
            if (count > maxRequests) {
                maxRequests = count;
            }
        }

        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < k; i++) {
            if (requestCounts[i] == maxRequests) {
                result.add(i);
            }
        }

        return result;
    }
}