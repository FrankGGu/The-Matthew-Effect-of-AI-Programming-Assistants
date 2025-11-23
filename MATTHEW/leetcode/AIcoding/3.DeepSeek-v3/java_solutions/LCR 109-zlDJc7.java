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
                    char c = current.charAt(j);
                    String up = current.substring(0, j) + (c == '9' ? '0' : (char)(c + 1)) + current.substring(j + 1);
                    if (!visited.contains(up) && !dead.contains(up)) {
                        visited.add(up);
                        queue.offer(up);
                    }
                    String down = current.substring(0, j) + (c == '0' ? '9' : (char)(c - 1)) + current.substring(j + 1);
                    if (!visited.contains(down) && !dead.contains(down)) {
                        visited.add(down);
                        queue.offer(down);
                    }
                }
            }
            steps++;
        }
        return -1;
    }
}