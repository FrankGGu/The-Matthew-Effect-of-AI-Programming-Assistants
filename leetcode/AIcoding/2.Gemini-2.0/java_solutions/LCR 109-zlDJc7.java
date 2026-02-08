import java.util.*;

class Solution {
    public int openLock(String[] deadends, String target) {
        Set<String> dead = new HashSet<>(Arrays.asList(deadends));
        if (dead.contains("0000")) return -1;
        if (target.equals("0000")) return 0;

        Queue<String> queue = new LinkedList<>();
        queue.offer("0000");
        Set<String> visited = new HashSet<>();
        visited.add("0000");
        int level = 0;

        while (!queue.isEmpty()) {
            level++;
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String curr = queue.poll();
                List<String> nexts = getNext(curr);
                for (String next : nexts) {
                    if (next.equals(target)) return level;
                    if (!dead.contains(next) && !visited.contains(next)) {
                        queue.offer(next);
                        visited.add(next);
                    }
                }
            }
        }
        return -1;
    }

    private List<String> getNext(String curr) {
        List<String> nexts = new ArrayList<>();
        for (int i = 0; i < 4; i++) {
            char c = curr.charAt(i);
            String s1 = curr.substring(0, i) + (c == '9' ? '0' : (char) (c + 1)) + curr.substring(i + 1);
            String s2 = curr.substring(0, i) + (c == '0' ? '9' : (char) (c - 1)) + curr.substring(i + 1);
            nexts.add(s1);
            nexts.add(s2);
        }
        return nexts;
    }
}