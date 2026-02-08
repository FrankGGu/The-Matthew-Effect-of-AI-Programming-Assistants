import java.util.*;

class Solution {
    public boolean sequenceReconstruction(int[] org, List<List<Integer>> seqs) {
        int n = org.length;
        List<Integer>[] adj = new List[n + 1];
        int[] inDegree = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            adj[i] = new ArrayList<>();
        }

        int count = 0;
        for (List<Integer> seq : seqs) {
            for (int i = 0; i < seq.size(); i++) {
                if (seq.get(i) < 1 || seq.get(i) > n) return false;
                if (i < seq.size() - 1) {
                    int u = seq.get(i);
                    int v = seq.get(i + 1);
                    if (!adj[u].contains(v)) {
                        adj[u].add(v);
                        inDegree[v]++;
                        count++;
                    }
                }
            }
        }

        if (count == 0 && seqs.size() > 0 && (seqs.get(0).size() == 0)) return false;

        Queue<Integer> q = new LinkedList<>();
        for (int i = 1; i <= n; i++) {
            if (inDegree[i] == 0) {
                q.offer(i);
            }
        }

        int index = 0;
        while (!q.isEmpty()) {
            if (q.size() > 1) return false;
            int u = q.poll();
            if (index >= n || org[index++] != u) return false;

            for (int v : adj[u]) {
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.offer(v);
                }
            }
        }

        return index == n;
    }
}