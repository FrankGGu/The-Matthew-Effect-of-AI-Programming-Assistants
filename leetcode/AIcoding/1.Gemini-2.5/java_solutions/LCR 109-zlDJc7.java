import java.util.Queue;
import java.util.LinkedList;
import java.util.Set;
import java.util.HashSet;

class Solution {
    public int openLock(String[] deadends, String target) {
        Set<String> deads = new HashSet<>();
        for (String d : deadends) {
            deads.add(d);
        }

        if (deads.contains("0000")) {
            return -1;
        }
        if (target.equals("0000")) {
            return 0;
        }

        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();

        queue.offer("0000");
        visited.add("0000");

        int level = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();

                if (current.equals(target)) {
                    return level;
                }

                for (int j = 0; j < 4; j++) {
                    char[] chars = current.toCharArray();
                    char originalChar = chars[j];

                    // Turn up
                    chars[j] = (char)(((originalChar - '0' + 1) % 10) + '0');
                    String nextUp = new String(chars);
                    if (!visited.contains(nextUp) && !deads.contains(nextUp)) {
                        visited.add(nextUp);
                        queue.offer(nextUp);
                    }

                    // Turn down
                    chars[j] = (char)(((originalChar - '0' + 9) % 10) + '0');
                    String nextDown = new String(chars);
                    if (!visited.contains(nextDown) && !deads.contains(nextDown)) {
                        visited.add(nextDown);
                        queue.offer(nextDown);
                    }
                }
            }
            level++;
        }

        return -1;
    }
}