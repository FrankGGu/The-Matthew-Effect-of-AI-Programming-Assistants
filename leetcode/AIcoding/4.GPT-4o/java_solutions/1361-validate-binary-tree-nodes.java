class Solution {
    public boolean validateBinaryTreeNodes(int n, int[] leftChild, int[] rightChild) {
        int[] indegree = new int[n];
        for (int i = 0; i < n; i++) {
            if (leftChild[i] != -1) {
                indegree[leftChild[i]]++;
            }
            if (rightChild[i] != -1) {
                indegree[rightChild[i]]++;
            }
        }

        int rootCount = 0;
        for (int i = 0; i < n; i++) {
            if (indegree[i] == 0) {
                rootCount++;
            } else if (indegree[i] > 1) {
                return false;
            }
        }

        return rootCount == 1 && isConnected(n, leftChild, rightChild);
    }

    private boolean isConnected(int n, int[] leftChild, int[] rightChild) {
        boolean[] visited = new boolean[n];
        dfs(0, leftChild, rightChild, visited);
        for (boolean v : visited) {
            if (!v) return false;
        }
        return true;
    }

    private void dfs(int node, int[] leftChild, int[] rightChild, boolean[] visited) {
        visited[node] = true;
        if (leftChild[node] != -1) {
            dfs(leftChild[node], leftChild, rightChild, visited);
        }
        if (rightChild[node] != -1) {
            dfs(rightChild[node], leftChild, rightChild, visited);
        }
    }
}