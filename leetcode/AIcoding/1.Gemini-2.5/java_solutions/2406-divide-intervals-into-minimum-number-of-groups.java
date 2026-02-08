import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int minGroups(int[][] intervals) {
        // Sort intervals by their start times
        Arrays.sort(intervals, (a, b) -> a[0] - b[0]);

        // Min-heap to store the end times of intervals in current groups.
        // The smallest end time is at the top, representing the group that becomes free earliest.
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();

        for (int[] interval : intervals) {
            int start = interval[0];
            int end = interval[1];

            // If the current interval's start time is greater than or equal to
            // the smallest end time in the heap, it means this interval can
            // be added to an existing group (the one that finishes earliest).
            // So, we remove that group's end time from consideration, as it's now free.
            if (!minHeap.isEmpty() && start > minHeap.peek()) {
                minHeap.poll();
            }

            // Add the current interval's end time to the heap.
            // This effectively assigns it to a group (either a new one or the one just freed).
            minHeap.offer(end);
        }

        // The size of the heap at the end represents the maximum number of groups
        // that were simultaneously active at any point, which is the minimum
        // number of groups required to satisfy the condition.
        return minHeap.size();
    }
}