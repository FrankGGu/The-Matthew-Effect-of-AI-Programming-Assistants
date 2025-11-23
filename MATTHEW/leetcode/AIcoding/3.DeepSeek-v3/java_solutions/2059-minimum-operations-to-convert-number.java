class Solution {
    public int minimumOperations(int[] nums, int start, int goal) {
        Queue<Integer> queue = new LinkedList<>();
        Set<Integer> visited = new HashSet<>();
        queue.offer(start);
        visited.add(start);
        int operations = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int current = queue.poll();
                if (current == goal) {
                    return operations;
                }
                if (current < 0 || current > 1000) {
                    continue;
                }
                for (int num : nums) {
                    int[] nextValues = {current + num, current - num, current ^ num};
                    for (int next : nextValues) {
                        if (next == goal) {
                            return operations + 1;
                        }
                        if (next >= 0 && next <= 1000 && !visited.contains(next)) {
                            visited.add(next);
                            queue.offer(next);
                        }
                    }
                }
            }
            operations++;
        }
        return -1;
    }
}