import java.util.PriorityQueue;
import java.util.Collections;

class Solution {
    public int solve(int[] times, int k) {
        if (k <= 0) {
            // Handle invalid k, or throw an exception, depending on problem constraints.
            // Assuming k >= 1 for a valid security check setup.
            // If k=0, no one can be processed, so it might be Integer.MAX_VALUE or -1.
            // For this problem, let's assume k >= 1. If times is empty, 0.
            return times.length == 0 ? 0 : -1; // Or throw IllegalArgumentException
        }

        PriorityQueue<Integer> checkpointFinishTimes = new PriorityQueue<>();

        // Initialize k checkpoints, all free at time 0
        for (int i = 0; i < k; i++) {
            checkpointFinishTimes.offer(0);
        }

        // Process each person
        for (int timeRequired : times) {
            // Get the checkpoint that will become free earliest
            int earliestAvailableTime = checkpointFinishTimes.poll();

            // Assign the current person to this checkpoint
            // The person will finish at earliestAvailableTime + timeRequired
            int newFinishTime = earliestAvailableTime + timeRequired;

            // Update the checkpoint's finish time in the priority queue
            checkpointFinishTimes.offer(newFinishTime);
        }

        // After all people are processed, the maximum finish time among all checkpoints
        // is the total time required for everyone to pass.
        int maxTotalTime = 0;
        while (!checkpointFinishTimes.isEmpty()) {
            maxTotalTime = Math.max(maxTotalTime, checkpointFinishTimes.poll());
        }

        return maxTotalTime;
    }
}