class Solution {
    public String longestDiverseString(int a, int b, int c) {
        StringBuilder sb = new StringBuilder();
        PriorityQueue<int[]> pq = new PriorityQueue<>((x, y) -> y[0] - x[0]);
        if (a > 0) pq.offer(new int[]{a, 0});
        if (b > 0) pq.offer(new int[]{b, 1});
        if (c > 0) pq.offer(new int[]{c, 2});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int count = curr[0];
            int type = curr[1];

            if (sb.length() >= 2 && getType(sb.charAt(sb.length() - 1)) == type && getType(sb.charAt(sb.length() - 2)) == type) {
                if (pq.isEmpty()) break;
                int[] next = pq.poll();
                int nextCount = next[0];
                int nextType = next[1];
                sb.append(getChar(nextType));
                next[0]--;
                if (next[0] > 0) pq.offer(next);
                pq.offer(curr);
            } else {
                sb.append(getChar(type));
                curr[0]--;
                if (curr[0] > 0) pq.offer(curr);
            }
        }

        return sb.toString();
    }

    private char getChar(int type) {
        if (type == 0) return 'a';
        if (type == 1) return 'b';
        return 'c';
    }

    private int getType(char c) {
        if (c == 'a') return 0;
        if (c == 'b') return 1;
        return 2;
    }
}