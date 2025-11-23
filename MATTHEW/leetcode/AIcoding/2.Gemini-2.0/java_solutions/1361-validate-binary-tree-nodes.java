import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Set;

class Solution {
    public boolean validateBinaryTreeNodes(int n, int[] leftChild, int[] rightChild) {
        int root = -1;
        int[] inDegree = new int[n];
        for (int i = 0; i < n; i++) {
            if (leftChild[i] != -1) {
                inDegree[leftChild[i]]++;
            }
            if (rightChild[i] != -1) {
                inDegree[rightChild[i]]++;
            }
        }
        int rootCount = 0;
        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                root = i;
                rootCount++;
            }
        }
        if (rootCount != 1) {
            return false;
        }

        Queue<Integer> queue = new LinkedList<>();
        queue.offer(root);
        Set<Integer> visited = new HashSet<>();
        visited.add(root);
        int count = 0;

        while (!queue.isEmpty()) {
            int node = queue.poll();
            count++;

            if (leftChild[node] != -1) {
                if (visited.contains(leftChild[node])) {
                    return false;
                }
                queue.offer(leftChild[node]);
                visited.add(leftChild[node]);
            }

            if (rightChild[node] != -1) {
                if (visited.contains(rightChild[node])) {
                    return false;
                }
                queue.offer(rightChild[node]);
                visited.add(rightChild[node]);
            }
        }

        return count == n;
    }
}