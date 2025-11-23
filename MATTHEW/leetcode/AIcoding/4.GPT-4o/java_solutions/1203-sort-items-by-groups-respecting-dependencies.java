import java.util.*;

public class Solution {
    public List<Integer> sortItems(int n, int m, int[][] group, List<List<Integer>> beforeItems) {
        Map<Integer, List<Integer>> itemGraph = new HashMap<>();
        Map<Integer, List<Integer>> groupGraph = new HashMap();
        int[] itemIndegree = new int[n];
        int[] groupIndegree = new int[m];

        for (int i = 0; i < n; i++) {
            itemGraph.put(i, new ArrayList<>());
        }

        for (int i = 0; i < m; i++) {
            groupGraph.put(i, new ArrayList<>());
        }

        for (int i = 0; i < n; i++) {
            if (group[i] == -1) {
                group[i] = m++;
            }
        }

        for (int i = 0; i < n; i++) {
            for (int before : beforeItems[i]) {
                itemGraph.get(before).add(i);
                itemIndegree[i]++;
                if (group[before] != group[i]) {
                    groupGraph.get(group[before]).add(group[i]);
                    groupIndegree[group[i]]++;
                }
            }
        }

        List<Integer> itemOrder = topologicalSort(itemGraph, itemIndegree);
        List<Integer> groupOrder = topologicalSort(groupGraph, groupIndegree);

        if (itemOrder.size() != n || groupOrder.size() != m) {
            return new ArrayList<>();
        }

        Map<Integer, List<Integer>> groupToItems = new HashMap<>();
        for (int item : itemOrder) {
            groupToItems.putIfAbsent(group[item], new ArrayList<>());
            groupToItems.get(group[item]).add(item);
        }

        List<Integer> result = new ArrayList<>();
        for (int g : groupOrder) {
            if (groupToItems.containsKey(g)) {
                result.addAll(groupToItems.get(g));
            }
        }

        return result;
    }

    private List<Integer> topologicalSort(Map<Integer, List<Integer>> graph, int[] indegree) {
        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < indegree.length; i++) {
            if (indegree[i] == 0) {
                queue.offer(i);
            }
        }

        List<Integer> order = new ArrayList<>();
        while (!queue.isEmpty()) {
            int node = queue.poll();
            order.add(node);
            for (int neighbor : graph.get(node)) {
                indegree[neighbor]--;
                if (indegree[neighbor] == 0) {
                    queue.offer(neighbor);
                }
            }
        }
        return order;
    }
}