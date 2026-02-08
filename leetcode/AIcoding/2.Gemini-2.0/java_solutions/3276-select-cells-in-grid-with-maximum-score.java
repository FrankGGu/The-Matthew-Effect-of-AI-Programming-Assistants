class Solution {
    public long maxScore(int[] row, int[] col) {
        int m = row.length;
        int n = col.length;
        PriorityQueue<Integer> rowQueue = new PriorityQueue<>( (a, b) -> b - a);
        PriorityQueue<Integer> colQueue = new PriorityQueue<>( (a, b) -> b - a);

        for (int r : row) {
            rowQueue.offer(r);
        }

        for (int c : col) {
            colQueue.offer(c);
        }

        long ans = 0;
        long rowCnt = 0;
        long colCnt = 0;

        while (!rowQueue.isEmpty() && !colQueue.isEmpty()) {
            if (rowQueue.peek() > colQueue.peek()) {
                ans += rowQueue.poll();
                rowCnt++;
            } else {
                ans += colQueue.poll();
                colCnt++;
            }
        }

        while (rowCnt < m && !rowQueue.isEmpty()) {
            ans += rowQueue.poll();
        }

        while (colCnt < n && !colQueue.isEmpty()) {
            ans += colQueue.poll();
        }

        return ans;
    }
}