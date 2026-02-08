import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public boolean validateBinaryTreeNodes(int n, int[] leftChild, int[] rightChild) {
        int[] inDegree = new int[n];

        for (int i = 0; i < n; i++) {
            if (leftChild[i] != -1) {
                if (leftChild[i] == i) { // Self-loop check
                    return false;
                }
                inDegree[leftChild[i]]++;
                if (inDegree[leftChild[i]] > 1) { // Node has more than one parent
                    return false;
                }
            }
            if (rightChild[i] != -1) {
                if (rightChild[i] == i) { // Self-loop check
                    return false;
                }
                inDegree[rightChild[i]]++;
                if (inDegree[rightChild[i]] > 1) { // Node has more than one parent
                    return false;
                }
            }
        }

        int root = -1;
        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                if (root != -1) { // More than one root found
                    return false;
                }
                root = i;
            }
        }

        if (root == -1) { // No root found (e.g., a cycle involving all nodes, or disconnected components without a root)
            return false;
        }

        Queue<Integer> queue = new LinkedList<>();
        boolean[] visited = new boolean[n];
        int visitedCount = 0;

        queue.offer(root);
        visited[root] = true;
        visitedCount++;

        while (!queue.isEmpty()) {
            int node = queue.poll();

            int left = leftChild[node];
            if (left != -1) {
                if (visited[left]) { // Cycle detected
                    return false;
                }
                visited[left] = true;
                visitedCount++;
                queue.offer(left);
            }

            int right = rightChild[node];
            if (right != -1) {
                if (visited[right]) { // Cycle detected
                    return false;
                }
                visited[right] = true;
                visitedCount++;
                queue.offer(right);
            }
        }

        return visitedCount == n;
    }
}