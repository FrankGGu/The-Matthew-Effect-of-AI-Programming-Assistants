class Solution {
    public int openLock(String[] deadends, String target) {
        Set<String> dead = new HashSet<>(Arrays.asList(deadends));
        Set<String> visited = new HashSet<>();
        Queue<String> queue = new LinkedList<>();
        queue.offer("0000");
        visited.add("0000");
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();
                if (dead.contains(current)) {
                    continue;
                }
                if (current.equals(target)) {
                    return steps;
                }
                for (int j = 0; j < 4; j++) {
                    char[] chars = current.toCharArray();
                    char c = chars[j];
                    chars[j] = c == '9' ? '0' : (char)(c + 1);
                    String next1 = new String(chars);
                    if (!visited.contains(next1) && !dead.contains(next1)) {
                        visited.add(next1);
                        queue.offer(next1);
                    }
                    chars[j] = c == '0' ? '9' : (char)(c - 1);
                    String next2 = new String(chars);
                    if (!visited.contains(next2) && !dead.contains(next2)) {
                        visited.add(next2);
                        queue.offer(next2);
                    }
                }
            }
            steps++;
        }
        return -1;
    }
}