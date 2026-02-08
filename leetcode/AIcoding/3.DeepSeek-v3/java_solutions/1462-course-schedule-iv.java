class Solution {
    public List<Boolean> checkIfPrerequisite(int numCourses, int[][] prerequisites, int[][] queries) {
        boolean[][] reachable = new boolean[numCourses][numCourses];

        for (int[] pre : prerequisites) {
            int u = pre[0], v = pre[1];
            reachable[u][v] = true;
        }

        for (int k = 0; k < numCourses; k++) {
            for (int i = 0; i < numCourses; i++) {
                for (int j = 0; j < numCourses; j++) {
                    if (reachable[i][k] && reachable[k][j]) {
                        reachable[i][j] = true;
                    }
                }
            }
        }

        List<Boolean> result = new ArrayList<>();
        for (int[] query : queries) {
            int u = query[0], v = query[1];
            result.add(reachable[u][v]);
        }
        return result;
    }
}