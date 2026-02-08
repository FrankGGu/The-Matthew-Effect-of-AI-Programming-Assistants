class Solution {
    public int[] unmarkedSumArray(int[] nums, int[][] queries) {
        int n = nums.length;
        int m = queries.length;
        boolean[] marked = new boolean[n];
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            } else {
                return a[1] - b[1];
            }
        });

        long sum = 0;
        for (int i = 0; i < n; i++) {
            sum += nums[i];
            pq.offer(new int[]{nums[i], i});
        }

        int[] res = new int[m];
        for (int i = 0; i < m; i++) {
            int index = queries[i][0];
            int k = queries[i][1];

            if (!marked[index]) {
                marked[index] = true;
                sum -= nums[index];
            }

            while (k > 0 && !pq.isEmpty()) {
                int[] curr = pq.poll();
                if (!marked[curr[1]]) {
                    marked[curr[1]] = true;
                    sum -= curr[0];
                    k--;
                }
            }

            res[i] = (int) sum;
        }

        return res;
    }
}