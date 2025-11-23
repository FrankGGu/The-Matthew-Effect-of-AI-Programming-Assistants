class Solution {
    public int kthSmallest(int[][] mat, int k) {
        int m = mat.length;
        int n = mat[0].length;

        PriorityQueue<Integer> pq = new PriorityQueue<>(Collections.reverseOrder());
        pq.offer(0);

        for (int[] row : mat) {
            PriorityQueue<Integer> nextPq = new PriorityQueue<>(Collections.reverseOrder());
            for (int sum : pq) {
                for (int num : row) {
                    nextPq.offer(sum + num);
                    if (nextPq.size() > k) {
                        nextPq.poll();
                    }
                }
            }
            pq = nextPq;
        }

        return pq.peek();
    }
}