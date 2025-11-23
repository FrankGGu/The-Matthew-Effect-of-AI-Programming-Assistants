import java.util.*;

public class Solution {
    public int[] sequenceReconstruction(int[] org, List<List<Integer>> seqs) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        int[] inDegree = new int[org.length + 1];

        for (List<Integer> seq : seqs) {
            for (int num : seq) {
                if (num > org.length || num < 1) return new int[0];
                graph.putIfAbsent(num, new ArrayList<>());
            }
            for (int i = 1; i < seq.size(); i++) {
                int u = seq.get(i - 1), v = seq.get(i);
                graph.get(u).add(v);
                inDegree[v]++;
            }
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 1; i <= org.length; i++) {
            if (inDegree[i] == 0) queue.offer(i);
        }

        int[] result = new int[org.length];
        int index = 0;

        while (!queue.isEmpty()) {
            if (queue.size() > 1) return new int[0];
            int current = queue.poll();
            result[index++] = current;
            for (int neighbor : graph.get(current)) {
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) queue.offer(neighbor);
            }
        }

        return index == org.length && Arrays.equals(result, org) ? result : new int[0];
    }
}