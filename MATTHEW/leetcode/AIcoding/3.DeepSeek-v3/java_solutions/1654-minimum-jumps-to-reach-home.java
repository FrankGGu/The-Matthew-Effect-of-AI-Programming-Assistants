class Solution {
    public int minimumJumps(int[] forbidden, int a, int b, int x) {
        Set<Integer> forbiddenSet = new HashSet<>();
        for (int num : forbidden) {
            forbiddenSet.add(num);
        }
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 0, 0}); // {position, jumps, direction (0=forward, 1=backward)}
        Set<String> visited = new HashSet<>();
        visited.add(0 + "," + 0);
        int maxLimit = 2000 + 2 * Math.max(a, b); // To cover possible positions

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int pos = current[0];
            int jumps = current[1];
            int dir = current[2];

            if (pos == x) {
                return jumps;
            }

            // Try forward jump
            int nextPos = pos + a;
            if (nextPos <= maxLimit && !forbiddenSet.contains(nextPos) && !visited.contains(nextPos + "," + 0)) {
                visited.add(nextPos + "," + 0);
                queue.offer(new int[]{nextPos, jumps + 1, 0});
            }

            // Try backward jump only if previous move was not backward
            if (dir == 0) {
                nextPos = pos - b;
                if (nextPos >= 0 && !forbiddenSet.contains(nextPos) && !visited.contains(nextPos + "," + 1)) {
                    visited.add(nextPos + "," + 1);
                    queue.offer(new int[]{nextPos, jumps + 1, 1});
                }
            }
        }

        return -1;
    }
}