class Solution {
    public int countArtifacts(int[][] artifacts) {
        int n = artifacts.length;
        boolean[] visited = new boolean[n];
        int count = 0;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                count++;
                dfs(artifacts, visited, i);
            }
        }
        return count;
    }

    private void dfs(int[][] artifacts, boolean[] visited, int index) {
        visited[index] = true;
        for (int i = 0; i < artifacts.length; i++) {
            if (!visited[i] && canExtract(artifacts[index], artifacts[i])) {
                dfs(artifacts, visited, i);
            }
        }
    }

    private boolean canExtract(int[] artifactA, int[] artifactB) {
        return artifactA[0] < artifactB[0] && artifactA[1] < artifactB[1];
    }
}