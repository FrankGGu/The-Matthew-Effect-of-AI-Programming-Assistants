import java.util.*;

class Solution {
    public int[] sortItems(int n, int m, int[] group, List<List<Integer>> beforeItems) {
        for (int i = 0; i < n; i++) {
            if (group[i] == -1) {
                group[i] = m++;
            }
        }

        List<Integer>[] itemGraph = new List[n];
        int[] itemIndegree = new int[n];
        for (int i = 0; i < n; i++) {
            itemGraph[i] = new ArrayList<>();
        }

        List<Integer>[] groupGraph = new List[m];
        int[] groupIndegree = new int[m];
        for (int i = 0; i < m; i++) {
            groupGraph[i] = new ArrayList<>();
        }

        for (int i = 0; i < n; i++) {
            for (int beforeItem : beforeItems.get(i)) {
                if (group[i] == group[beforeItem]) {
                    itemGraph[beforeItem].add(i);
                    itemIndegree[i]++;
                } else {
                    if (!groupGraph[group[beforeItem]].contains(group[i])) {
                        groupGraph[group[beforeItem]].add(group[i]);
                        groupIndegree[group[i]]++;
                    }
                }
            }
        }

        List<Integer> itemOrder = topologicalSort(itemGraph, itemIndegree);
        List<Integer> groupOrder = topologicalSort(groupGraph, groupIndegree);

        if (itemOrder.size() == 0 || groupOrder.size() == 0) {
            return new int[0];
        }

        Map<Integer, List<Integer>> groupToItems = new HashMap<>();
        for (int item : itemOrder) {
            groupToItems.computeIfAbsent(group[item], k -> new ArrayList<>()).add(item);
        }

        List<Integer> result = new ArrayList<>();
        for (int groupId : groupOrder) {
            if (groupToItems.containsKey(groupId)) {
                result.addAll(groupToItems.get(groupId));
            }
        }

        return result.stream().mapToInt(Integer::intValue).toArray();
    }

    private List<Integer> topologicalSort(List<Integer>[] graph, int[] indegree) {
        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < indegree.length; i++) {
            if (indegree[i] == 0) {
                queue.offer(i);
            }
        }

        List<Integer> result = new ArrayList<>();
        while (!queue.isEmpty()) {
            int node = queue.poll();
            result.add(node);
            for (int neighbor : graph[node]) {
                indegree[neighbor]--;
                if (indegree[neighbor] == 0) {
                    queue.offer(neighbor);
                }
            }
        }

        return result.size() == indegree.length ? result : new ArrayList<>();
    }
}