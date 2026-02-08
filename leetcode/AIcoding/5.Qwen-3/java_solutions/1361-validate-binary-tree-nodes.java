public class Solution {

import java.util.*;

public class Solution {
    public boolean validateBinaryTreeNodes(int[] leftChild, int[] rightChild) {
        int n = leftChild.length;
        Map<Integer, List<Integer>> graph = new HashMap<>();
        int[] inDegree = new int[n];

        for (int i = 0; i < n; i++) {
            if (leftChild[i] != -1) {
                graph.computeIfAbsent(i, k -> new ArrayList<>()).add(leftChild[i]);
                inDegree[leftChild[i]]++;
            }
            if (rightChild[i] != -1) {
                graph.computeIfAbsent(i, k -> new ArrayList<>()).add(rightChild[i]);
                inDegree[rightChild[i]]++;
            }
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                queue.add(i);
            }
        }

        if (queue.size() != 1) {
            return false;
        }

        int count = 0;
        while (!queue.isEmpty()) {
            int node = queue.poll();
            count++;
            for (int neighbor : graph.getOrDefault(node, new ArrayList<>())) {
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    queue.add(neighbor);
                }
            }
        }

        return count == n;
    }
}
}