class Solution {
    public int eatenApples(int[] apples, int[] days) {
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        int n = apples.length;
        int res = 0;
        for (int i = 0; i < n || !pq.isEmpty(); i++) {
            if (i < n && apples[i] > 0) {
                pq.offer(new int[]{i + days[i], apples[i]});
            }
            while (!pq.isEmpty() && pq.peek()[0] <= i) {
                pq.poll();
            }
            if (!pq.isEmpty()) {
                int[] cur = pq.poll();
                cur[1]--;
                res++;
                if (cur[1] > 0) {
                    pq.offer(cur);
                }
            }
        }
        return res;
    }
}