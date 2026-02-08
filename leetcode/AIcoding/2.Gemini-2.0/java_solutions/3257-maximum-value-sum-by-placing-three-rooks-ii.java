class Solution {
    public long maximumValueSum(int[] nums, int[][] rooks) {
        int n = nums.length;
        long sum = 0;
        for (int num : nums) {
            sum += num;
        }

        long maxReduction = 0;
        for (int i = 0; i < rooks.length; i++) {
            for (int j = i + 1; j < rooks.length; j++) {
                for (int k = j + 1; k < rooks.length; k++) {
                    long currentReduction = 0;
                    boolean[] visited = new boolean[n];

                    int r1 = rooks[i][0];
                    int c1 = rooks[i][1];

                    int r2 = rooks[j][0];
                    int c2 = rooks[j][1];

                    int r3 = rooks[k][0];
                    int c3 = rooks[k][1];

                    if (!visited[c1]) {
                        currentReduction += nums[c1];
                        visited[c1] = true;
                    }
                    if (!visited[c2]) {
                        currentReduction += nums[c2];
                        visited[c2] = true;
                    }
                    if (!visited[c3]) {
                        currentReduction += nums[c3];
                        visited[c3] = true;
                    }

                    maxReduction = Math.max(maxReduction, currentReduction);
                }
            }
        }

        if (rooks.length >= 1) {
            for (int i = 0; i < rooks.length; i++) {
                long currentReduction = 0;
                boolean[] visited = new boolean[n];

                int r1 = rooks[i][0];
                int c1 = rooks[i][1];

                if (!visited[c1]) {
                    currentReduction += nums[c1];
                    visited[c1] = true;
                }
                maxReduction = Math.max(maxReduction, currentReduction);
            }
        }

        if (rooks.length >= 2) {
            for (int i = 0; i < rooks.length; i++) {
                for (int j = i + 1; j < rooks.length; j++) {
                    long currentReduction = 0;
                    boolean[] visited = new boolean[n];

                    int r1 = rooks[i][0];
                    int c1 = rooks[i][1];

                    int r2 = rooks[j][0];
                    int c2 = rooks[j][1];

                    if (!visited[c1]) {
                        currentReduction += nums[c1];
                        visited[c1] = true;
                    }
                    if (!visited[c2]) {
                        currentReduction += nums[c2];
                        visited[c2] = true;
                    }

                    maxReduction = Math.max(maxReduction, currentReduction);
                }
            }
        }

        return sum - maxReduction;
    }
}