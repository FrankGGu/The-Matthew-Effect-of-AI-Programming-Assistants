class Solution {
    public int[][] validArrangement(int[][] pairs) {
        Map<Integer, Deque<Integer>> graph = new HashMap<>();
        Map<Integer, Integer> outDegree = new HashMap<>();
        for (int[] pair : pairs) {
            int u = pair[0], v = pair[1];
            graph.computeIfAbsent(u, k -> new ArrayDeque<>()).add(v);
            outDegree.put(u, outDegree.getOrDefault(u, 0) + 1);
            outDegree.put(v, outDegree.getOrDefault(v, 0) - 1);
        }
        int start = pairs[0][0];
        for (int key : outDegree.keySet()) {
            if (outDegree.get(key) == 1) {
                start = key;
                break;
            }
        }
        List<int[]> path = new ArrayList<>();
        Deque<Integer> stack = new ArrayDeque<>();
        stack.push(start);
        while (!stack.isEmpty()) {
            int u = stack.peek();
            if (graph.containsKey(u) && !graph.get(u).isEmpty()) {
                int v = graph.get(u).poll();
                stack.push(v);
            } else {
                if (stack.size() > 1) {
                    int v = stack.pop();
                    path.add(new int[]{stack.peek(), v});
                } else {
                    stack.pop();
                }
            }
        }
        Collections.reverse(path);
        int[][] result = new int[path.size()][2];
        for (int i = 0; i < path.size(); i++) {
            result[i] = path.get(i);
        }
        return result;
    }
}