class Solution {
    public boolean validateBinaryTreeNodes(int n, int[] leftChild, int[] rightChild) {
        int[] inDegree = new int[n];
        for (int i = 0; i < n; i++) {
            if (leftChild[i] != -1) {
                inDegree[leftChild[i]]++;
                if (inDegree[leftChild[i]] > 1) {
                    return false;
                }
            }
            if (rightChild[i] != -1) {
                inDegree[rightChild[i]]++;
                if (inDegree[rightChild[i]] > 1) {
                    return false;
                }
            }
        }
        int root = -1;
        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                if (root != -1) {
                    return false;
                }
                root = i;
            }
        }
        if (root == -1) {
            return false;
        }
        boolean[] visited = new boolean[n];
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(root);
        visited[root] = true;
        int count = 1;
        while (!queue.isEmpty()) {
            int node = queue.poll();
            if (leftChild[node] != -1) {
                if (visited[leftChild[node]]) {
                    return false;
                }
                visited[leftChild[node]] = true;
                queue.offer(leftChild[node]);
                count++;
            }
            if (rightChild[node] != -1) {
                if (visited[rightChild[node]]) {
                    return false;
                }
                visited[rightChild[node]] = true;
                queue.offer(rightChild[node]);
                count++;
            }
        }
        return count == n;
    }
}