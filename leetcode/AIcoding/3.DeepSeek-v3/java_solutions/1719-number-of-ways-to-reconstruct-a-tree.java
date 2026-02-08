class Solution {
    public int checkWays(int[][] pairs) {
        Map<Integer, Set<Integer>> adj = new HashMap<>();
        for (int[] pair : pairs) {
            int u = pair[0], v = pair[1];
            adj.computeIfAbsent(u, k -> new HashSet<>()).add(v);
            adj.computeIfAbsent(v, k -> new HashSet<>()).add(u);
        }

        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> adj.get(b).size() - adj.get(a).size());
        pq.addAll(adj.keySet());

        int total = pq.size();
        boolean multiple = false;
        int root = pq.peek();
        if (adj.get(root).size() != total - 1) {
            return 0;
        }

        Set<Integer> seen = new HashSet<>();
        while (!pq.isEmpty()) {
            int u = pq.poll();
            seen.add(u);

            int parent = -1;
            int parentSize = Integer.MAX_VALUE;
            for (int v : adj.get(u)) {
                if (!seen.contains(v) && adj.get(v).size() < parentSize && adj.get(v).size() >= adj.get(u).size()) {
                    parent = v;
                    parentSize = adj.get(v).size();
                }
            }

            if (parent == -1) {
                continue;
            }

            for (int v : adj.get(u)) {
                if (v != parent && !adj.get(parent).contains(v)) {
                    return 0;
                }
            }

            if (adj.get(parent).size() == adj.get(u).size()) {
                multiple = true;
            }
        }

        return multiple ? 2 : 1;
    }
}