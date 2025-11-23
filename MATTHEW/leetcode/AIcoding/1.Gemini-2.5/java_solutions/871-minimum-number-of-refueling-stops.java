import java.util.PriorityQueue;
import java.util.Collections;

class Solution {
    public int minRefuelStops(int target, int startFuel, int[][] stations) {
        // Max-heap to store fuel available at stations we've passed but haven't used yet.
        // We use Collections.reverseOrder() to make it a max-heap.
        PriorityQueue<Integer> pq = new PriorityQueue<>(Collections.reverseOrder());

        long currentFuel = startFuel; // Use long for currentFuel to prevent overflow
        int stops = 0;
        int prevStationLocation = 0; // Location of the last station or the starting point

        // Iterate through each station
        for (int[] station : stations) {
            int stationLocation = station[0];
            int stationFuel = station[1];

            // Calculate distance to the current station from the previous point
            // and deduct the required fuel.
            currentFuel -= (stationLocation - prevStationLocation);

            // If current fuel is negative, it means we ran out of fuel before reaching this station.
            // We must refuel from the stations we've passed that offer the most fuel.
            while (currentFuel < 0 && !pq.isEmpty()) {
                currentFuel += pq.poll(); // Add the largest available fuel from a past station
                stops++; // Increment the refueling stop count
            }

            // If after refueling from all available past stations, current fuel is still negative,
            // it's impossible to reach this station.
            if (currentFuel < 0) {
                return -1;
            }

            // Add the current station's fuel to the priority queue.
            // This fuel can be used if we need to refuel later.
            pq.offer(stationFuel);

            // Update the previous station location to the current station's location.
            prevStationLocation = stationLocation;
        }

        // After iterating through all stations, we still need to reach the target.
        // Deduct fuel needed to cover the distance from the last station to the target.
        currentFuel -= (target - prevStationLocation);

        // If current fuel is negative, we need to refuel to reach the target.
        while (currentFuel < 0 && !pq.isEmpty()) {
            currentFuel += pq.poll(); // Add the largest available fuel from a past station
            stops++; // Increment the refueling stop count
        }

        // If after all possible refueling, current fuel is still negative,
        // it's impossible to reach the target.
        if (currentFuel < 0) {
            return -1;
        }

        // If we reached here, it means we can reach the target. Return the minimum stops.
        return stops;
    }
}