import java.util.*;

class Solution {
    public List<List<Integer>> getSkyline(int[][] buildings) {
        List<List<Integer>> result = new ArrayList<>();
        List<int[]> events = new ArrayList<>();
        for (int[] b : buildings) {
            events.add(new int[]{b[0], -b[2], b[1]});
            events.add(new int[]{b[1], b[2], b[1]});
        }
        Collections.sort(events, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            } else {
                return a[1] - b[1];
            }
        });

        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> (b - a));
        pq.add(0);
        int prevHeight = 0;

        for (int[] event : events) {
            if (event[1] < 0) {
                pq.add(-event[1]);
            } else {
                pq.remove(event[1]);
            }

            int currentHeight = pq.peek();
            if (currentHeight != prevHeight) {
                result.add(Arrays.asList(event[0], currentHeight));
                prevHeight = currentHeight;
            }
        }

        return result;
    }
}