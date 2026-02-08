class Solution {
    public int racecar(int target) {
        Queue<int[]> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();
        queue.offer(new int[]{0, 1}); // position, speed
        visited.add("0:1");
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] current = queue.poll();
                int pos = current[0], speed = current[1];

                if (pos == target) return steps;

                // Move forward
                int nextPos = pos + speed;
                int nextSpeed = speed * 2;
                String forwardState = nextPos + ":" + nextSpeed;
                if (Math.abs(nextPos) <= 2 * target && !visited.contains(forwardState)) {
                    queue.offer(new int[]{nextPos, nextSpeed});
                    visited.add(forwardState);
                }

                // Reverse
                nextSpeed = speed > 0 ? -1 : 1;
                String reverseState = pos + ":" + nextSpeed;
                if (!visited.contains(reverseState)) {
                    queue.offer(new int[]{pos, nextSpeed});
                    visited.add(reverseState);
                }
            }
            steps++;
        }
        return -1;
    }
}