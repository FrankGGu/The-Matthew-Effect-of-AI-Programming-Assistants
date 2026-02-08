import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int maxEvents(int[][] events) {
        // Sort events by their start day.
        Arrays.sort(events, (a, b) -> a[0] - b[0]);

        // Min-priority queue to store the end days of events that are currently available
        // (i.e., they have started, but not yet ended, and we haven't attended them).
        // We want to attend the event that ends earliest to free up future days.
        PriorityQueue<Integer> pq = new PriorityQueue<>();

        int attendedEvents = 0;
        int eventIndex = 0; // Pointer to the next event to be added from the sorted 'events' array
        int currentDay = 1; // Start processing from day 1

        // Loop as long as there are events to consider (either in the 'events' array
        // or in the priority queue).
        while (eventIndex < events.length || !pq.isEmpty()) {
            // If the priority queue is empty, it means there are no events available
            // to attend right now. We can jump 'currentDay' to the start day of the
            // next available event to avoid unnecessary iterations.
            if (pq.isEmpty() && eventIndex < events.length) {
                currentDay = events[eventIndex][0];
            }

            // Add all events that start on or before 'currentDay' to the priority queue.
            // These are events that are now available to be attended.
            while (eventIndex < events.length && events[eventIndex][0] <= currentDay) {
                pq.add(events[eventIndex][1]); // Add the end day of the event
                eventIndex++;
            }

            // Remove events from the priority queue that have already ended before 'currentDay'.
            // These events can no longer be attended.
            while (!pq.isEmpty() && pq.peek() < currentDay) {
                pq.poll();
            }

            // If there are still events in the priority queue, it means we can attend one
            // on 'currentDay'. We pick the one with the earliest end day (min-heap property).
            if (!pq.isEmpty()) {
                pq.poll(); // Attend this event (remove it from consideration)
                attendedEvents++;
            }

            // Move to the next day.
            currentDay++;
        }

        return attendedEvents;
    }
}