class Solution {
    public int kthLargestValue(int[][] matrix, int k) {
        int m = matrix.length;
        int n = matrix[0].length;
        int[][] xor = new int[m][n];
        PriorityQueue<Integer> pq = new PriorityQueue<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int val = matrix[i][j];
                if (i > 0) val ^= xor[i - 1][j];
                if (j > 0) val ^= xor[i][j - 1];
                if (i > 0 && j > 0) val ^= xor[i - 1][j - 1];
                xor[i][j] = val;

                pq.offer(val);
                if (pq.size() > k) {
                    pq.poll();
                }
            }
        }

        return pq.peek();
    }
}