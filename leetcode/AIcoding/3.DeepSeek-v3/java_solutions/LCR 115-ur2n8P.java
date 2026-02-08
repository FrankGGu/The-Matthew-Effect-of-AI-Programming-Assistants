class Solution {
    public boolean sequenceReconstruction(int[] org, List<List<Integer>> seqs) {
        Map<Integer, Set<Integer>> graph = new HashMap<>();
        Map<Integer, Integer> inDegree = new HashMap<>();

        for (List<Integer> seq : seqs) {
            for (int num : seq) {
                if (num <= 0 || num > org.length) {
                    return false;
                }
                graph.putIfAbsent(num, new HashSet<>());
                inDegree.putIfAbsent(num, 0);
            }
        }

        if (graph.size() != org.length) {
            return false;
        }

        for (List<Integer> seq : seqs) {
            for (int i = 0; i < seq.size() - 1; i++) {
                int from = seq.get(i);
                int to = seq.get(i + 1);
                if (!graph.get(from).contains(to)) {
                    graph.get(from).add(to);
                    inDegree.put(to, inDegree.get(to) + 1);
                }
            }
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int key : inDegree.keySet()) {
            if (inDegree.get(key) == 0) {
                queue.offer(key);
            }
        }

        int index = 0;
        while (!queue.isEmpty()) {
            if (queue.size() > 1) {
                return false;
            }
            int current = queue.poll();
            if (index >= org.length || current != org[index]) {
                return false;
            }
            index++;
            for (int neighbor : graph.get(current)) {
                inDegree.put(neighbor, inDegree.get(neighbor) - 1);
                if (inDegree.get(neighbor) == 0) {
                    queue.offer(neighbor);
                }
            }
        }

        return index == org.length;
    }
}