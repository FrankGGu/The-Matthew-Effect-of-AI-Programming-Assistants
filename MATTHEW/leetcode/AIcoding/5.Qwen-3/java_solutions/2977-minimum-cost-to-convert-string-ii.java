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

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        for (char c : dist.keySet()) {
            pq.offer(new int[]{c, 0});
        }

        while (!pq.isEmpty()) {
            int[] node = pq.poll();
            char curr = (char) node[0];
            int currCost = node[1];

            if (currCost > dist.get(curr)) {
                continue;
            }

            if (graph.containsKey(curr)) {
                for (int[] neighbor : graph.get(curr)) {
                    char nextChar = (char) neighbor[0];
                    int nextCost = currCost + neighbor[1];
                    if (nextCost < dist.get(nextChar)) {
                        dist.put(nextChar, nextCost);
                        pq.offer(new int[]{nextChar, nextCost});
                    }
                }
            }
        }

        int total = 0;
        for (int i = 0; i < source.length(); i++) {
            if (source.charAt(i) == target.charAt(i)) {
                continue;
            }
            int costToConvert = dist.getOrDefault(target.charAt(i), Integer.MAX_VALUE);
            if (costToConvert == Integer.MAX_VALUE) {
                return -1;
            }
            total += costToConvert;
        }

        return total;
    }
}
}