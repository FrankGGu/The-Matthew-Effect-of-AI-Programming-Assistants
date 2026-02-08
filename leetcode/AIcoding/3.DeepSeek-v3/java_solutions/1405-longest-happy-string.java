class Solution {
    public String longestDiverseString(int a, int b, int c) {
        StringBuilder sb = new StringBuilder();
        PriorityQueue<int[]> pq = new PriorityQueue<>((x, y) -> y[1] - x[1]);
        if (a > 0) pq.offer(new int[]{0, a});
        if (b > 0) pq.offer(new int[]{1, b});
        if (c > 0) pq.offer(new int[]{2, c});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int n = sb.length();
            if (n >= 2 && sb.charAt(n - 1) - 'a' == curr[0] && sb.charAt(n - 2) - 'a' == curr[0]) {
                if (pq.isEmpty()) break;
                int[] next = pq.poll();
                sb.append((char) (next[0] + 'a'));
                next[1]--;
                if (next[1] > 0) pq.offer(next);
                pq.offer(curr);
            } else {
                sb.append((char) (curr[0] + 'a'));
                curr[1]--;
                if (curr[1] > 0) pq.offer(curr);
            }
        }
        return sb.toString();
    }
}