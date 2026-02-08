import java.util.*;

class Solution {
    public List<List<Integer>> getSkyline(int[][] buildings) {
        List<List<Integer>> result = new ArrayList<>();
        List<int[]> heights = new ArrayList<>();

        for (int[] b : buildings) {
            heights.add(new int[] {b[0], -b[2]});
            heights.add(new int[] {b[1], b[2]});
        }

        Collections.sort(heights, (a, b) -> {
            if (a[0] == b[0]) return a[1] - b[1];
            return a[0] - b[0];
        });

        Queue<Integer> pq = new PriorityQueue<>(Collections.reverseOrder());
        pq.offer(0);

        int prevMax = 0;

        for (int[] h : heights) {
            if (h[1] < 0) {
                pq.offer(-h[1]);
            } else {
                pq.remove(h[1]);
            }

            int currentMax = pq.peek();
            if (currentMax != prevMax) {
                result.add(Arrays.asList(h[0], currentMax));
                prevMax = currentMax;
            }
        }

        return result;
    }
}