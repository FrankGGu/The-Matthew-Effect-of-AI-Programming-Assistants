class Solution {
    public int[] longestObstacleCourseAtEachPosition(int[] obstacles) {
        int n = obstacles.length;
        int[] dp = new int[n];
        List<Integer> lis = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            int idx = Collections.binarySearch(lis, obstacles[i]);
            if (idx < 0) idx = -(idx + 1);
            if (idx < lis.size()) {
                lis.set(idx, obstacles[i]);
            } else {
                lis.add(obstacles[i]);
            }
            dp[i] = idx + 1;
        }

        return dp;
    }
}