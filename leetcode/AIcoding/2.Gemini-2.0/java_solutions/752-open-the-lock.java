import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Set;

class Solution {
    public int openLock(String[] deadends, String target) {
        Set<String> dead = new HashSet<>();
        for (String s : deadends) {
            dead.add(s);
        }

        if (dead.contains("0000")) {
            return -1;
        }

        Queue<String> queue = new LinkedList<>();
        queue.offer("0000");
        Set<String> visited = new HashSet<>();
        visited.add("0000");
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String curr = queue.poll();
                if (curr.equals(target)) {
                    return steps;
                }

                for (int j = 0; j < 4; j++) {
                    char c = curr.charAt(j);
                    String s1 = curr.substring(0, j) + (c == '9' ? '0' : (char) (c + 1)) + curr.substring(j + 1);
                    String s2 = curr.substring(0, j) + (c == '0' ? '9' : (char) (c - 1)) + curr.substring(j + 1);

                    if (!dead.contains(s1) && !visited.contains(s1)) {
                        queue.offer(s1);
                        visited.add(s1);
                    }
                    if (!dead.contains(s2) && !visited.contains(s2)) {
                        queue.offer(s2);
                        visited.add(s2);
                    }
                }
            }
            steps++;
        }

        return -1;
    }
}