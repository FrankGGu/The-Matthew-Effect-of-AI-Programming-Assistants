class Solution {
    public int[] countVisitedNodes(List<Integer> edges) {
        int n = edges.size();
        int[] res = new int[n];
        boolean[] visited = new boolean[n];

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                List<Integer> path = new ArrayList<>();
                int curr = i;
                while (curr != -1 && !visited[curr]) {
                    visited[curr] = true;
                    path.add(curr);
                    curr = edges.get(curr);
                }
                if (curr == -1) {
                    for (int j = 0; j < path.size(); j++) {
                        res[path.get(j)] = path.size() - j;
                    }
                } else {
                    int idx = path.indexOf(curr);
                    if (idx != -1) {
                        int cycleLen = path.size() - idx;
                        for (int j = idx; j < path.size(); j++) {
                            res[path.get(j)] = cycleLen;
                        }
                        for (int j = 0; j < idx; j++) {
                            res[path.get(j)] = path.size() - j;
                        }
                    } else {
                        for (int j = 0; j < path.size(); j++) {
                            res[path.get(j)] = res[curr] + path.size() - j;
                        }
                    }
                }
            }
        }
        return res;
    }
}