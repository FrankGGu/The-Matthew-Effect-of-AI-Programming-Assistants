class Solution {
    public int minBuildTime(int[] blocks, int split) {
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        for (int block : blocks) {
            pq.offer(block);
        }
        while (pq.size() > 1) {
            int x = pq.poll();
            int y = pq.poll();
            pq.offer(y + split);
        }
        return pq.poll();
    }
}