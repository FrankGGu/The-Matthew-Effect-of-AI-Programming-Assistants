class Solution {
    public long findScore(int[] nums) {
        int n = nums.length;
        boolean[] marked = new boolean[n];
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            } else {
                return a[1] - b[1];
            }
        });

        for (int i = 0; i < n; i++) {
            pq.offer(new int[]{nums[i], i});
        }

        long score = 0;
        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int num = curr[0];
            int idx = curr[1];
            if (!marked[idx]) {
                score += num;
                marked[idx] = true;
                if (idx > 0) {
                    marked[idx - 1] = true;
                }
                if (idx < n - 1) {
                    marked[idx + 1] = true;
                }
            }
        }

        return score;
    }
}