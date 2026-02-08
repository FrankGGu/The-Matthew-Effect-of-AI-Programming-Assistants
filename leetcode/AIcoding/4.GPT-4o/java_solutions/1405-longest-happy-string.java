import java.util.PriorityQueue;

class Solution {
    public String longestDiverseString(int a, int b, int c) {
        PriorityQueue<int[]> pq = new PriorityQueue<>((x, y) -> y[1] - x[1]);
        if (a > 0) pq.offer(new int[]{0, a});
        if (b > 0) pq.offer(new int[]{1, b});
        if (c > 0) pq.offer(new int[]{2, c});

        StringBuilder result = new StringBuilder();

        while (!pq.isEmpty()) {
            int[] first = pq.poll();
            int[] second = pq.isEmpty() ? null : pq.peek();

            if (result.length() >= 2 && result.charAt(result.length() - 1) - 'a' == first[0] && result.charAt(result.length() - 2) - 'a' == first[0]) {
                if (second == null) break;
                result.append((char) ('a' + second[0]));
                second[1]--;
                if (second[1] == 0) pq.poll();
                pq.offer(first);
            } else {
                result.append((char) ('a' + first[0]));
                first[1]--;
                if (first[1] == 0) continue;
                pq.offer(first);
            }
        }

        return result.toString();
    }
}