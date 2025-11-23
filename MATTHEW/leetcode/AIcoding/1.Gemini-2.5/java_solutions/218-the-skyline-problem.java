import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.PriorityQueue;
import java.util.Arrays;

class Solution {
    public List<List<Integer>> getSkyline(int[][] buildings) {
        List<List<Integer>> events = new ArrayList<>();
        for (int[] b : buildings) {
            // Start point: x-coordinate, negative height (to denote start and for sorting)
            events.add(Arrays.asList(b[0], -b[2]));
            // End point: x-coordinate, positive height
            events.add(Arrays.asList(b[1], b[2]));
        }

        // Sort events:
        // 1. By x-coordinate (ascending)
        // 2. If x-coordinates are the same:
        //    a. If both are start points (negative heights): Process taller building first (smaller negative value).
        //    b. If both are end points (positive heights): Process shorter building first (smaller positive value).
        //    c. If one is start (negative height) and one is end (positive height): Process start point first.
        // This combined logic is achieved by `a[1] - b[1]`.
        Collections.sort(events, (a, b) -> {
            if (!a.get(0).equals(b.get(0))) {
                return a.get(0) - b.get(0);
            }
            return a.get(1) - b.get(1);
        });

        List<List<Integer>> result = new ArrayList<>();
        // Max-heap to store the heights of active buildings
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        // Add 0 to handle cases where no buildings are active, ensuring peek() never returns null
        maxHeap.add(0);

        int prevMaxHeight = 0;

        for (List<Integer> event : events) {
            int x = event.get(0);
            int height = event.get(1);

            if (height < 0) { // This is a start point
                maxHeap.add(-height);
            } else { // This is an end point
                maxHeap.remove(height);
            }

            int currentMaxHeight = maxHeap.peek();

            // If the maximum height changes, add a key point to the result
            if (currentMaxHeight != prevMaxHeight) {
                result.add(Arrays.asList(x, currentMaxHeight));
                prevMaxHeight = currentMaxHeight;
            }
        }

        return result;
    }
}