public class Solution {

import java.util.*;

public class Solution {
    public int openLock(String[] deadends, String target) {
        Set<String> dead = new HashSet<>(Arrays.asList(deadends));
        if (dead.contains("0000")) return -1;
        Queue<String> queue = new LinkedList<>();
        queue.offer("0000");
        Set<String> visited = new HashSet<>();
        visited.add("0000");
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();
                if (current.equals(target)) return steps;
                for (int j = 0; j < 4; j++) {
                    for (int k = -1; k <= 1; k += 2) {
                        char[] next = current.toCharArray();
                        next[j] = (char) (((next[j] - '0') + k + 10) % 10 + '0');
                        String nextStr = new String(next);
                        if (!visited.contains(nextStr) && !dead.contains(nextStr)) {
                            visited.add(nextStr);
                            queue.offer(nextStr);
                        }
                    }
                }
            }
            steps++;
        }
        return -1;
    }
}
}