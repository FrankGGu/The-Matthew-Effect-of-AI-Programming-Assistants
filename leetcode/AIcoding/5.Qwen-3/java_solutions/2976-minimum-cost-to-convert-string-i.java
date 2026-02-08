public class Solution {

import java.util.*;

public class Solution {
    public int minCost(String source, String target, char[] original, char[] changed, int[] cost) {
        Map<Character, List<int[]>> graph = new HashMap<>();
        for (int i = 0; i < original.length; i++) {
            graph.putIfAbsent(original[i], new ArrayList<>());
            graph.get(original[i]).add(new int[]{changed[i], cost[i]});
        }

        Map<Character, Integer> dist = new HashMap<>();
        for (char c : source.toCharArray()) {
            dist.put(c, Integer.MAX_VALUE);
        }
        for (char c : target.toCharArray()) {
            dist.put(c, Integer.MAX_VALUE);
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        for (char c : dist.keySet()) {
            pq.add(new int[]{c, 0});
        }

        while (!pq.isEmpty()) {
            int[] node = pq.poll();
            char u = (char) node[0];
            int d = node[1];

            if (d > dist.get(u)) continue;

            if (graph.containsKey(u)) {
                for (int[] edge : graph.get(u)) {
                    char v = (char) edge[0];
                    int w = edge[1];
                    if (dist.get(v) > d + w) {
                        dist.put(v, d + w);
                        pq.add(new int[]{v, d + w});
                    }
                }
            }
        }

        int total = 0;
        for (int i = 0; i < source.length(); i++) {
            char s = source.charAt(i);
            char t = target.charAt(i);
            if (s == t) continue;
            if (dist.get(s) == Integer.MAX_VALUE || dist.get(t) == Integer.MAX_VALUE) {
                return -1;
            }
            total += dist.get(t);
        }

        return total;
    }
}
}