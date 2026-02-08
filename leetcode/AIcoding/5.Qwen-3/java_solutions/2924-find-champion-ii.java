public class Solution {

import java.util.*;

public class Solution {
    public int findChampion(int n, int[][] edges) {
        int[] inDegree = new int[n];
        for (int[] edge : edges) {
            inDegree[edge[1]]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                queue.add(i);
            }
        }

        int count = 0;
        int champion = -1;
        while (!queue.isEmpty()) {
            int node = queue.poll();
            count++;
            champion = node;
            for (int[] edge : edges) {
                if (edge[0] == node && inDegree[edge[1]] > 0) {
                    inDegree[edge[1]]--;
                    if (inDegree[edge[1]] == 0) {
                        queue.add(edge[1]);
                    }
                }
            }
        }

        return count == n ? champion : -1;
    }
}
}