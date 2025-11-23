import java.util.*;

class Solution {
    public int longestCycle(int[] edges) {
        int n = edges.length;
        int[] visited = new int[n];
        int[] stack = new int[n];
        int maxLength = -1;

        for (int i = 0; i < n; i++) {
            if (visited[i] == 0) {
                Set<Integer> currentPath = new HashSet<>();
                int currentIndex = i;
                int length = 0;

                while (currentIndex != -1 && visited[currentIndex] == 0) {
                    visited[currentIndex] = 1;
                    currentPath.add(currentIndex);
                    stack[length++] = currentIndex;
                    currentIndex = edges[currentIndex];
                }

                if (currentIndex != -1 && currentPath.contains(currentIndex)) {
                    int cycleLength = 0;
                    for (int j = length - 1; j >= 0; j--) {
                        cycleLength++;
                        if (stack[j] == currentIndex) break;
                    }
                    maxLength = Math.max(maxLength, cycleLength);
                }

                for (int j = 0; j < length; j++) {
                    visited[stack[j]] = 2;
                }
            }
        }
        return maxLength;
    }
}