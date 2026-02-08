import java.util.*;

class Solution {
    public int[] sortItems(int n, int m, int[] group, List<List<Integer>> beforeItems) {
        int groupId = m;
        for (int i = 0; i < n; i++) {
            if (group[i] == -1) {
                group[i] = groupId++;
            }
        }

        Map<Integer, List<Integer>> itemGraph = new HashMap<>();
        int[] itemInDegree = new int[n];
        for (int i = 0; i < n; i++) {
            itemGraph.put(i, new ArrayList<>());
        }

        Map<Integer, List<Integer>> groupGraph = new HashMap<>();
        int[] groupInDegree = new int[groupId];
        for (int i = 0; i < groupId; i++) {
            groupGraph.put(i, new ArrayList<>());
        }

        for (int i = 0; i < n; i++) {
            for (int before : beforeItems.get(i)) {
                itemGraph.get(before).add(i);
                itemInDegree[i]++;
                if (group[before] != group[i]) {
                    groupGraph.get(group[before]).add(group[i]);
                    groupInDegree[group[i]]++;
                }
            }
        }

        List<Integer> itemOrder = topologicalSort(itemGraph, itemInDegree);
        List<Integer> groupOrder = topologicalSort(groupGraph, groupInDegree);

        if (itemOrder.isEmpty() || groupOrder.isEmpty()) {
            return new int[0];
        }

        Map<Integer, List<Integer>> groupToItems = new HashMap<>();
        for (int item : itemOrder) {
            groupToItems.computeIfAbsent(group[item], k -> new ArrayList<>()).add(item);
        }

        List<Integer> sortedItems = new ArrayList<>();
        for (int groupIndex : groupOrder) {
            sortedItems.addAll(groupToItems.getOrDefault(groupIndex, new ArrayList<>()));
        }

        return sortedItems.stream().mapToInt(i -> i).toArray();
    }

    private List<Integer> topologicalSort(Map<Integer, List<Integer>> graph, int[] inDegree) {
        List<Integer> result = new ArrayList<>();
        Queue<Integer> queue = new LinkedList<>();
        for (int node : graph.keySet()) {
            if (inDegree[node] == 0) {
                queue.offer(node);
            }
        }

        while (!queue.isEmpty()) {
            int node = queue.poll();
            result.add(node);
            for (int neighbor : graph.get(node)) {
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    queue.offer(neighbor);
                }
            }
        }

        return result.size() == graph.size() ? result : new ArrayList<>();
    }
}