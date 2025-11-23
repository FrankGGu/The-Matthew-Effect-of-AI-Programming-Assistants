public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> sortItems(int n, int m, int[] group, List<List<Integer>> beforeItems) {
        List<Integer> result = new ArrayList<>();
        Map<Integer, List<Integer>> graph = new HashMap<>();
        Map<Integer, Integer> inDegree = new HashMap<>();
        Map<Integer, List<Integer>> groupGraph = new HashMap<>();
        Map<Integer, Integer> groupInDegree = new HashMap<>();

        for (int i = 0; i < n; i++) {
            if (!graph.containsKey(i)) {
                graph.put(i, new ArrayList<>());
                inDegree.put(i, 0);
            }
        }

        for (int i = 0; i < m; i++) {
            if (!groupGraph.containsKey(i)) {
                groupGraph.put(i, new ArrayList<>());
                groupInDegree.put(i, 0);
            }
        }

        for (int i = 0; i < n; i++) {
            if (group[i] == -1) {
                group[i] = m++;
                groupGraph.put(group[i], new ArrayList<>());
                groupInDegree.put(group[i], 0);
            }
        }

        for (int i = 0; i < n; i++) {
            for (int item : beforeItems.get(i)) {
                if (!graph.get(item).contains(i)) {
                    graph.get(item).add(i);
                    inDegree.put(i, inDegree.get(i) + 1);
                }
            }
        }

        for (int i = 0; i < n; i++) {
            int currentGroup = group[i];
            for (int j = 0; j < n; j++) {
                if (i != j && group[j] != currentGroup && beforeItems.get(j).contains(i)) {
                    int fromGroup = group[i];
                    int toGroup = group[j];
                    if (!groupGraph.get(fromGroup).contains(toGroup)) {
                        groupGraph.get(fromGroup).add(toGroup);
                        groupInDegree.put(toGroup, groupInDegree.get(toGroup) + 1);
                    }
                }
            }
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int node : inDegree.keySet()) {
            if (inDegree.get(node) == 0) {
                queue.add(node);
            }
        }

        while (!queue.isEmpty()) {
            int node = queue.poll();
            result.add(node);
            for (int neighbor : graph.get(node)) {
                inDegree.put(neighbor, inDegree.get(neighbor) - 1);
                if (inDegree.get(neighbor) == 0) {
                    queue.add(neighbor);
                }
            }
        }

        if (result.size() != n) {
            return new ArrayList<>();
        }

        Queue<Integer> groupQueue = new LinkedList<>();
        for (int groupNode : groupInDegree.keySet()) {
            if (groupInDegree.get(groupNode) == 0) {
                groupQueue.add(groupNode);
            }
        }

        List<Integer> groupResult = new ArrayList<>();
        while (!groupQueue.isEmpty()) {
            int groupNode = groupQueue.poll();
            groupResult.add(groupNode);
            for (int neighbor : groupGraph.get(groupNode)) {
                groupInDegree.put(neighbor, groupInDegree.get(neighbor) - 1);
                if (groupInDegree.get(neighbor) == 0) {
                    groupQueue.add(neighbor);
                }
            }
        }

        if (groupResult.size() != groupInDegree.size()) {
            return new ArrayList<>();
        }

        Map<Integer, List<Integer>> groupToItems = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int g = group[i];
            if (!groupToItems.containsKey(g)) {
                groupToItems.put(g, new ArrayList<>());
            }
            groupToItems.get(g).add(i);
        }

        List<Integer> finalResult = new ArrayList<>();
        for (int g : groupResult) {
            List<Integer> items = groupToItems.get(g);
            for (int item : items) {
                finalResult.add(item);
            }
        }

        return finalResult;
    }
}
}