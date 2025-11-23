public class Solution {

import java.util.*;

public class Solution {
    public int maxCandies(int[] candies, int[] boxes, int[] r, int[] m, int n) {
        boolean[] visited = new boolean[n];
        Set<Integer> haveKey = new HashSet<>();
        Queue<Integer> queue = new LinkedList<>();

        for (int i = 0; i < n; i++) {
            if (r[i] == 0) {
                queue.add(i);
                visited[i] = true;
            } else {
                haveKey.add(r[i]);
            }
        }

        int result = 0;

        while (!queue.isEmpty()) {
            int box = queue.poll();
            result += candies[box];

            for (int i = 0; i < n; i++) {
                if (boxes[i] == box && !visited[i]) {
                    visited[i] = true;
                    if (r[i] == 0) {
                        queue.add(i);
                    } else {
                        haveKey.add(r[i]);
                    }
                }
            }

            for (int i = 0; i < n; i++) {
                if (m[i] == box && !visited[i] && haveKey.contains(r[i])) {
                    visited[i] = true;
                    queue.add(i);
                }
            }
        }

        return result;
    }
}
}