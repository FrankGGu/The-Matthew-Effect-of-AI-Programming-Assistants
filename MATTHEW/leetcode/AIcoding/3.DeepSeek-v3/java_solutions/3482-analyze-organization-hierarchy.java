class Solution {
    public List<List<Integer>> analyzeHierarchy(int[][] employees) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        int ceo = -1;
        for (int[] emp : employees) {
            int id = emp[0];
            int managerId = emp[1];
            if (id == managerId) {
                ceo = id;
            } else {
                graph.computeIfAbsent(managerId, k -> new ArrayList<>()).add(id);
            }
        }

        List<List<Integer>> result = new ArrayList<>();
        if (ceo == -1) return result;

        Queue<Integer> queue = new LinkedList<>();
        queue.offer(ceo);

        while (!queue.isEmpty()) {
            int size = queue.size();
            List<Integer> level = new ArrayList<>();
            for (int i = 0; i < size; i++) {
                int current = queue.poll();
                level.add(current);
                if (graph.containsKey(current)) {
                    for (int subordinate : graph.get(current)) {
                        queue.offer(subordinate);
                    }
                }
            }
            result.add(level);
        }
        return result;
    }
}