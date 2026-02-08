class Solution {
    public int[] getBiggestThree(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        PriorityQueue<Integer> pq = new PriorityQueue<>(Collections.reverseOrder());

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                pq.offer(grid[i][j]);
                int radius = 1;
                while (i - radius >= 0 && i + radius < m && j - radius >= 0 && j + radius < n) {
                    int sum = 0;
                    for (int k = 0; k <= radius; k++) {
                        sum += grid[i - k][j - radius + k];
                    }
                    for (int k = 1; k <= radius; k++) {
                        sum += grid[i + k][j - radius + k];
                    }
                    for (int k = 1; k <= radius; k++) {
                        sum += grid[i + k][j + radius - k];
                    }
                    for (int k = 1; k < radius; k++) {
                        sum += grid[i - k][j + radius - k];
                    }
                    pq.offer(sum);
                    radius++;
                }
            }
        }

        Set<Integer> set = new HashSet<>();
        List<Integer> res = new ArrayList<>();
        while (!pq.isEmpty() && res.size() < 3) {
            int num = pq.poll();
            if (!set.contains(num)) {
                set.add(num);
                res.add(num);
            }
        }

        int[] ans = new int[res.size()];
        for (int i = 0; i < ans.length; i++) {
            ans[i] = res.get(i);
        }
        return ans;
    }
}